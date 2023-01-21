//
//  BaseViewController.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation
import UIKit


class BaseViewController<T: BaseViewModel>: UIViewController {
     var viewModel: T?
}
