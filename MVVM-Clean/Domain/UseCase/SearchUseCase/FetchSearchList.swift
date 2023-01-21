//
//  FetchSearchList.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import Combine


/// this will be responsible for doing one task only
class FetchSearchList: SingleUseCase {
    
    let repository: ItemsListRepository
    var page: Int
    var searchText: String
    
    init(repository: ItemsListRepository, page: Int, searchText:String) {
        self.repository = repository
        self.page = page
        self.searchText = searchText
    }
    
    func start() -> Future<Response?,ErrorResponse> {
        Future { [weak self] promise in
            
            self?.repository.getSearchList(searchText: self?.searchText ?? "", page: self?.page ?? 0) { result, error in
                
                if result != nil {
                    if let data = result as? ItemsModel {
                        //                        let itemList = data.itemsList.sorted { $0.login < $1.login }
                        promise(Result.success(result as Response?))
                        data.itemsList = data.itemsList.sorted { (channel1, channel2) -> Bool in
                                    let channelName1 = channel1.login
                                    let channelName2 = channel2.login
                                    return (channelName1.localizedCaseInsensitiveCompare(channelName2) == .orderedAscending)
                        }
                        let searchEntity = ItemsModel(totalCount: data.totalCount, inCompleteResults: data.inCompleteResults, itemsList: data.itemsList)
//                        let uniqueVals = uniq(vals) // [1, 4, 2, 6, 24, 15, 60]

                           promise(Result.success(searchEntity))
                    }
                }
                else {
                    promise(Result.failure(error!))
                }
            }
        }
    }
}
