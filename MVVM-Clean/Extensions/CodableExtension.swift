//
//  CodableExtension.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation


// MARK: - extension on encodale to help building it
extension Encodable {
  func asDictionary()  -> [String: Any]? {
    let data = try? JSONEncoder().encode(self)
      if(data == nil) {
          return nil
      }
    guard let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
      return nil
    }
    return dictionary
  }
}
