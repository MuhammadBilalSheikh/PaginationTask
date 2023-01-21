//
//  SearchViewModel.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import Combine
import UIKit


protocol SearchDelegate: AnyObject {
    func reloadTableView()
}

class SearchViewModel : BaseViewModel {
    
    var apiResponse: ItemsModel?
    var searchUseCase = SearchUseCase()
    weak var delegate : SearchDelegate?
    var page = 1
    var refresh : Bool = false
    var searchText: String?
    var totalPages: Int {
        get {
            return apiResponse?.totalCount ?? 0
        }
    }
    var currentCount: Int {
        get {
            return apiResponse?.itemsList.count ?? 0
        }
    }
    var oldCount: Int = 0
    var shouldFetchNextPage: Bool {
        get {
            return !isLoading && page < totalPages
        }
    }
    
    init(binding:SearchDelegate) {
        super.init(useCase: searchUseCase)
        self.delegate = binding
        let repository = ItemsListRemoteRepositoryIMPL(remote: ItemsListRemoteService())
        searchUseCase.fetchSearchList = FetchSearchList(repository: repository, page: page, searchText: searchText ?? "")
        
    }

    
    
    init(useCase: SearchUseCase) {
        
        super.init(useCase: useCase)
    }
    
    func fetchData() -> Future<Response?, ErrorResponse>? {
        let viewModelUseCase = self.useCase as! SearchUseCase
        self.isLoading = true
        self.showError = false
        viewModelUseCase.fetchSearchList?.page = page
        viewModelUseCase.fetchSearchList?.searchText = searchText ?? ""
        return viewModelUseCase.fetchSearchList?.start()
    }
    
    ///to avoid reloading all the data
    func calculateIndexPathsToReload(from newCount: Int ) -> [IndexPath] {
        
        return PresentationHelper.calculateIndexPathsToReload(from: newCount, oldCount: oldCount, section: 0)
    }
    
    func handleResponse(response: Response) {
        if refresh == true {
            apiResponse?.itemsList.removeAll()
        }
        if(apiResponse == nil) {
//            first time load Data
            apiResponse = response as? ItemsModel
        } else {
            let searchResponse =  response as! ItemsModel
            oldCount = currentCount
            let sorted = searchResponse.itemsList.sorted { $0.login.lowercased() < $1.login.lowercased() }
            apiResponse?.itemsList.append(contentsOf:sorted)
        }
    }
    
}
