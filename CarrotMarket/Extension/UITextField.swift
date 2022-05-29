//
//  UITextField.swift
//  CarrotMarket
//
//  Created by JongHo Park on 2022/05/26.
//

import Foundation
import UIKit
import Combine

extension UITextField {
  var textPublisher: AnyPublisher<String, Never> {
    NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
      .compactMap { $0.object as? UITextField }
      .compactMap(\.text)
      .eraseToAnyPublisher()
  }
}
