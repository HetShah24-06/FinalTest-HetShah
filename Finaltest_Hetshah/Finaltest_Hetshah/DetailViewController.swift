//
//  DetailViewController.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//

import UIKit

class DetailViewController: UIViewController {
    
    var drinkID: String?
    
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = drinkID {
            let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
            
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let result = try? decoder.decode(DrinkDetailList.self, from: data),
                           let detail = result.drinks.first {
                            DispatchQueue.main.async {
                                self.nameLabel.text = detail.strDrink
                                self.categoryLabel.text = "Category: \(detail.strCategory)"
                                self.typeLabel.text = "Type: \(detail.strAlcoholic)"
                                self.instructionsTextView.text = detail.strInstructions ?? "No instructions available"
                                
                                if let imgURL = URL(string: detail.strDrinkThumb) {
                                    DispatchQueue.global().async {
                                        if let imgData = try? Data(contentsOf: imgURL) {
                                            DispatchQueue.main.async {
                                                self.drinkImageView.image = UIImage(data: imgData)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
