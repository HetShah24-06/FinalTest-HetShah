//
//  APIService.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//

import Foundation
import UIKit

class APIService {

  func fetchDrinks(ingredient: String, viewController: UIViewController, completionHandler: @escaping ([Drink]) -> Void) {
    let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
    let urlString = baseURL + ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    guard let url = URL(string: urlString) else { return }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let data = data {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(DrinksResponse.self, from: data) {
          DispatchQueue.main.async {
            completionHandler(result.drinks ?? [])
          }
        }
      }
    }
    task.resume()
  }

  func fetchDrinkDetail(id: String, viewController: UIViewController, completionHandler: @escaping (DrinkDetail?) -> Void) {
    let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
    let urlString = baseURL + id
    guard let url = URL(string: urlString) else { return }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let data = data {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(DrinkDetailsResponse.self, from: data) {
          DispatchQueue.main.async {
            completionHandler(result.drinks?.first)
          }
        }
      }
    }
    task.resume()
  }
}
