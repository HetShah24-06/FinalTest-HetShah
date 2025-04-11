//
//  APIService.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//

import Foundation

class APIService {
  func fetchDrinks(by ingredient: String, completion: @escaping ([Drink]?) -> Void) {
    let encodedIngredient = ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(encodedIngredient)"
     
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }

      let result = try? JSONDecoder().decode(DrinkList.self, from: data)
      DispatchQueue.main.async {
        completion(result?.drinks)
      }
    }.resume()
  }

  func fetchDrinkDetails(by id: String, completion: @escaping (DrinkDetail?) -> Void) {
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
     
    guard let url = URL(string: urlString) else {
      completion(nil)
      return
    }

    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }

      let result = try? JSONDecoder().decode(DrinkDetailList.self, from: data)
      DispatchQueue.main.async {
        completion(result?.drinks.first)
      }
    }.resume()
  }
}
