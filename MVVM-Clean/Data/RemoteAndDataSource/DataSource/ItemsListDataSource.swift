//
//  ItemsListDataSource.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import Alamofire

///This will be our generic data source
///each data source for Contact  should implement this data source and fulfill its functions implementation
protocol ItemsListDataSource {
    
    func getSearchList(searchArg: SearchItemParms, completion: @escaping (_ result: ItemsModel?, _ error: ErrorResponse?) -> Void)

}
