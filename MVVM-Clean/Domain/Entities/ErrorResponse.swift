//
//  ErrorResponse.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation

///will Hold the error response with suitable message
struct ErrorResponse: Encodable, Error {

    let message: String
    
    init(message: String) {
        self.message = message
    }
    
}
