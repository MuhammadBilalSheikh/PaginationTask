//
//  Response.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation


//This will act like the base response object
protocol Response: Codable{
    var responseError : String? { get }
}
