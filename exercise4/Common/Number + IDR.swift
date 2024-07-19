//
//  Number + IDR.swift
//  exercise4
//
//  Created by Naufal Al-Fachri on 19/07/24.
//

import Foundation

extension Float {
  var idr: String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "id_ID")
    
    return formatter.string(from: NSNumber(value: self))
  }
}
