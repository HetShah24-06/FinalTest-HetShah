//
//  ViewController.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
   
    var drinks: [Drink] = []
      let apiService = APIService()

      override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
      }

      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let ingredient = searchBar.text, !ingredient.isEmpty else { return }
        apiService.fetchDrinks(ingredient: ingredient, viewController: self) { fetchedDrinks in
          self.drinks = fetchedDrinks
          self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drink = drinks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        cell.textLabel?.text = drink.strDrink

        if let url = URL(string: drink.strDrinkThumb) {
          DispatchQueue.global().async {
            if let imgData = try? Data(contentsOf: url) {
              DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imgData)
                cell.setNeedsLayout()
              }
            }
          }
        }
        return cell
      }

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
          let detailVC = segue.destination as? DetailViewController,
          let indexPath = tableView.indexPathForSelectedRow {
          detailVC.drinkID = drinks[indexPath.row].idDrink
        }
      }
    }
