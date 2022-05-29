//
//  Town.swift
//  CarrotMarket
//
//  Created by JongHo Park on 2022/05/26.
//

import Foundation

struct Town: Hashable {
  let city: String
  let dong: String
  let goo: String
}

extension Town: CustomStringConvertible {
  var description: String {
    "\(dong), \(city) \(goo)"
  }
}
