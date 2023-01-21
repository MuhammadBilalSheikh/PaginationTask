//
//  SearchItemParms.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation



struct SearchItemParms: PagingRequest, Codable {
    var page: Int
    var q: String
    var per_page: Int
}
