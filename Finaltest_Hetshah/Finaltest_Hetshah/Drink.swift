//
//  Drink.swift
//  Finaltest_Hetshah
//
//  Created by Het Shah on 2025-04-11.
//
import Foundation

struct DrinkList: Codable {
  let drinks: [Drink]
}

struct Drink: Codable {
  let strDrink: String
  let strDrinkThumb: String
  let idDrink: String
}

struct DrinkDetailList: Codable {
  let drinks: [DrinkDetail]
}

struct DrinkDetail: Codable {
  let strDrink: String
  let strCategory: String
  let strAlcoholic: String
  let strInstructions: String?
  let strInstructionsES: String?
  let strInstructionsDE: String?
  let strDrinkThumb: String
}
