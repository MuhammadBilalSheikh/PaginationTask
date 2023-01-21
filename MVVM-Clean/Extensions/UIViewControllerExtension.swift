//
//  UIViewControllerExtension.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlert(title: String, message: String, completion:  @escaping (UIAlertAction) -> Void) {
    let alertController = UIAlertController(title: title, message:
      message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "submit_button_title", style: .default, handler: completion))
    self.present(alertController, animated: true, completion: nil)
  }
}

