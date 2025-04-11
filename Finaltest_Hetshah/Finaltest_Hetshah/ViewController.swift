//
//  ViewController.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
   
     var drinks: [Drink] = []

     override func viewDidLoad() {
       super.viewDidLoad()
       title = "Cocktail Finder"
       searchBar.delegate = self
       tableView.dataSource = self
       tableView.delegate = self
     }

    func searchDrinks(ingredient: String) {
      let query = ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
      let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(query)"
       
      if let url = URL(string: urlString) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
          if let data = data {
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(DrinkList.self, from: data) {
              DispatchQueue.main.async {
                self.drinks = result.drinks
                self.tableView.reloadData()
              }
            }
          }
        }
        task.resume()
      }
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "showDetail",
         let detailVC = segue.destination as? DetailViewController,
         let indexPath = tableView.indexPathForSelectedRow {
         let selectedDrink = drinks[indexPath.row]
         detailVC.drinkID = selectedDrink.idDrink
       }
     }
   }

   extension ViewController: UISearchBarDelegate {
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       if let text = searchBar.text, !text.isEmpty {
         searchDrinks(ingredient: text)
         searchBar.resignFirstResponder()
       }
     }
   }

   extension ViewController: UITableViewDataSource, UITableViewDelegate {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       drinks.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
       let drink = drinks[indexPath.row]
       cell.textLabel?.text = drink.strDrink

       if let url = URL(string: drink.strDrinkThumb) {
         DispatchQueue.global().async {
           if let data = try? Data(contentsOf: url) {
             DispatchQueue.main.async {
               cell.imageView?.image = UIImage(data: data)
               cell.setNeedsLayout()
             }
           }
         }
       }

       return cell
     }
   }
