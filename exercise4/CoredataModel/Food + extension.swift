//
//  Food + extension.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//
import Foundation
//extension Food {
//  convenience init(name: String, description: String, category: String, price: Float, isComplete: Bool, date: Date) {
//    self.init(context: CoreDataManager.shared.context)
//    self.foodName = name
//    self.foodDescription = description
//    self.foodCategory = category
//    self.foodPrice = price
//    self.isComplete = isComplete
//    self.createDate = date
//  }
//}

extension FoodModel {
  func food() -> Food {
    Food(
      foodName: foodName,
      foodDescription: foodDescription,
      foodCategory: foodCategory,
      foodPrice: foodPrice,
      isComplete: isComplete,
      createDate: createDate
    )
  }
}

extension Food {
  func toDictionary() -> [String: Any] {
    [
      "foodName": foodName ?? "",
      "foodDescription": foodDescription ?? "",
      "foodCategory": foodCategory ?? "",
      "foodPrice": foodPrice ?? 0.0,
      "isComplete": isComplete ?? false,
      "createDate": createDate ?? .now
    ]
  }
}
