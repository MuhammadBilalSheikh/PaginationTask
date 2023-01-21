//
//  UITableViewExtension.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import UIKit

extension UITableView {
    func addSpinner(){
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
        self.tableFooterView = spinner
    }
}
