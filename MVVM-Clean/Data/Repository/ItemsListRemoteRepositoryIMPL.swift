//
//  ItemsListRemoteRepositoryIMPL.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import Alamofire

///Thtis class will be reponsible for implementing the Repository from the Domain Layer
final class ItemsListRemoteRepositoryIMPL {

    //this will represent the networking service for notification List
    //we can have another one for local if we had local storage
    private let remoteDateSource: ItemsListDataSource
    
    init(remote: ItemsListDataSource) {
        self.remoteDateSource = remote
    }
}

extension ItemsListRemoteRepositoryIMPL: ItemsListRepository {
    func getSearchList(searchText: String, page: Int, completion: @escaping (Response?, ErrorResponse?) -> Void) {
        let argsSearch = SearchItemParms(page: page, q: searchText, per_page:ConstantsPage.per_page )
        remoteDateSource.getSearchList(searchArg: argsSearch, completion: completion)
    }
}
