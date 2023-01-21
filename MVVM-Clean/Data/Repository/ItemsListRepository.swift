//
//  ItemsListRepository.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation


protocol ItemsListRepository {
    
    //we should add the implementation for this
    //we don't know where it's going to fetch data local or remote
    //for now we only care for remote    
    func getSearchList(searchText : String, page: Int, completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void)
}
