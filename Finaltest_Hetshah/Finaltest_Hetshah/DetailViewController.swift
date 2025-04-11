//
//  DetailViewController.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
        var drinkID: String?
         let apiService = APIService()

         override func viewDidLoad() {
           super.viewDidLoad()
           if let id = drinkID {
             apiService.fetchDrinkDetail(id: id, viewController: self) { detail in
               if let detail = detail {
                 self.nameLabel.text = detail.strDrink
                 self.categoryLabel.text = "Category: \(detail.strCategory)"
                 self.typeLabel.text = "Type: \(detail.strAlcoholic)"
                 self.instructionsTextView.text = detail.strInstructions ?? "No instructions"
                 if let imageURL = URL(string: detail.strDrinkThumb) {
                   DispatchQueue.global().async {
                     if let data = try? Data(contentsOf: imageURL) {
                       DispatchQueue.main.async {
                         self.drinkImageView.image = UIImage(data: data)
                       }
                     }
                   }
                 }
               }
             }
           }
         }
       }
