//
//  ItemsListRemoteService.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import Alamofire

// MARK: - Networking call within this class will happen
struct ItemsListRemoteService: ItemsListDataSource {
    
    func getSearchList(searchArg: SearchItemParms, completion: @escaping (ItemsModel?, ErrorResponse?) -> Void) {
        ///check the args if it's valid
        guard let params = searchArg.asDictionary() else { completion(nil, ErrorResponse(message: "args_error"))
            return
        }
        /// here we create the event that represent the endpoint
        let event = API(path:EndPoints.search , method: .get ,queryParameters: params, bodyEncoding:  JSONEncoding.default)
        ///here we call the request with our notification and completion handler
        BaseNetworking.shared.request(ItemsModel.self, endPoint: event, completion: completion)
    }
}

