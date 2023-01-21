//
//  BaseViewModel.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation
import UIKit


protocol BaseViewModelProtocol {
    associatedtype U
}

class BaseViewModel: BaseViewModelProtocol{
    typealias U = UseCase
    
    var useCase: U?
    var showError: Bool = false
    var isLoading: Bool = false

    init(useCase: U) {
        self.useCase = useCase
    }
}
