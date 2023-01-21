//
//  ItemsModel.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation


class ItemsModel: Response {
    var responseError: String?
    
    let totalCount: Int
    let inCompleteResults: Bool
    var itemsList: [ItemsList]
    
    enum CodingKeys: String, CodingKey  {
    case totalCount = "total_count"
    case inCompleteResults = "incomplete_results"
    case itemsList = "items"
    }
    
    init(totalCount: Int, inCompleteResults: Bool, itemsList: [ItemsList]){
        self.totalCount = totalCount
        self.inCompleteResults = inCompleteResults
        self.itemsList = itemsList
        
    }
    
}

// MARK: - ItemLists
struct ItemsList: Codable {
    let login: String

    let avatarURL: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case type

    }
}
