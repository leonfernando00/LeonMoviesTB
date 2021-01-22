//
//  LMConnectionService.swift
//  LeonMoviesTB
//
//  Created by Fernando León on 20/1/21.
//  Copyright © 2021 Fernando León. All rights reserved.
//

import UIKit
import Alamofire

class LMConnectionService: NSObject {
    
    typealias CompletionBlock = (Codable?, Error?, Int) -> ()
    
    //MARK: Static functions
    @discardableResult static func requestGET<T:Codable, R:Codable>(url: String, parameters: T, response: R.Type, timeout: TimeInterval = 30, auth: Bool = true, completion: @escaping CompletionBlock) -> DataRequest? {
        return request(url: url, method: .get, parameters: parameters, response: response, timeout: timeout, auth: auth, completion: completion)
    }
}

//MARK:- Private functions
private extension LMConnectionService {
    @discardableResult static func request<T:Codable, R:Codable>(url: String, method: HTTPMethod, parameters: T?, response: R.Type, timeout: TimeInterval, auth: Bool, allHeaders: [String:String] = [:], encoding : JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase, decoding : JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase, completion: @escaping CompletionBlock) -> DataRequest? {
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = encoding.self
        var body : [String: Any] = [:]
        if let param = try? parameters.asDictionary(encoder: encoder) {
            body = param
        }
        
        let request : DataRequest = Alamofire.request(buildUrl(withPath: url), method: method, parameters: body, encoding: method != .get ? JSONEncoding.default : URLEncoding.default, headers: HTTPHeaders())
                
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = timeout
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = timeout
        Alamofire.SessionManager.default.session.configuration.requestCachePolicy = .reloadIgnoringCacheData
        Alamofire.SessionManager.default.session.configuration.urlCache = nil
        
        return request.responseJSON { response in
            let statusCode =  response.response?.statusCode ?? 404
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil, response.error, statusCode)
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let object = try decoder.decode(R.self, from: data)
                    completion(object, nil, statusCode)
                } catch {
                    completion(nil, error, statusCode)
                }
            case .failure(let error):
                completion(nil, error, statusCode)
            }
        }
    }

    static func buildUrl(withPath path: String) -> String {
        return LMConstants.Url.base + path
    }
}
