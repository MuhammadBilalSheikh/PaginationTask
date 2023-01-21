//
//  PagingRequest.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation

protocol PagingRequest: Codable {
    
    var page: Int { get set}
    var q: String { get set}
    var per_page: Int { get set}

    
}
