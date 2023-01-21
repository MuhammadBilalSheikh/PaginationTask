//
//  BaseNetworking.swift
//  MVVM-Clean
//
//  Created by MBS on 18/01/2023.
//

import Foundation
import Alamofire
import Combine

// MARK: - Generic base networking class that will send request to the server and parse the response
class BaseNetworking {
    
    // MARK: Shared Instance
    public static let shared: BaseNetworking = BaseNetworking()
    
    ///To handle API calls and return the response
    func request<T: Codable>(_ t: T.Type,endPoint: API, completion: @escaping (_ result: T?, _ error: ErrorResponse?) -> Void)  {
        
        let url = buildRequestURL(endPoint: endPoint)
       
        if(url != nil) {
            let finalURL = url?.absoluteString.replacingOccurrences(of: "%3F", with: "?") ?? ""
            let URLinURL = URL(string: finalURL)
            ///herer we will call our API
            ///if it's sucess then return the object after parsing
            ///if it's failure then return error object
            print("URLinURL = \(URLinURL!)")
            AF.request(URLinURL!,
                       method: endPoint.method,
                       parameters:endPoint.method == .get ? endPoint.queryParameters  : endPoint.bodyParamaters,
                       encoding: endPoint.method == .get ? URLEncoding.default : endPoint.bodyEncoding            ).validate().responseDecodable(of: T.self)
            { (response) in
                
                switch response.result {
                case .success(_):
                    guard let response = response.value else
                    {
                        completion(nil, ErrorResponse(message: "parsing_error"))
                        return
                    }
                    print(response)
                    completion(response, nil)
               
                case .failure(_):
                    let res = try? JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? [String:Any]
                    completion(nil, ErrorResponse(message: res?["message"] as! String ))
                }
            }
            
        }else {
            completion(nil, ErrorResponse(message: "url_error"))
        }


    }
    
    
    /// in order to handle the get request with any query parameters
    private func buildRequestURL(endPoint: API) -> URL? {
        
//        let env = AppEnvironment.current
        
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = BaseURL.baseURL
        components.path = endPoint.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        
        ///if we have any query parameters we should add them here
//        components.queryItems = queryDictionary.map {
//            URLQueryItem(name: $0, value: "\($1)")
//        }
        
        print("URL : \(String(describing: components.url))")
//        var urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return components.url
    }
    
}

