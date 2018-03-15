//
//  APIDAO.swift
//  HeartstoneDustCounter
//
//  Created by Lucas Santos on 27/02/18.
//  Copyright © 2018 lucasSantos. All rights reserved.
//

import Foundation

class APIDAO {
    
    class func requestToApi(url: String, queryDic: [(String, String)]?, headerDic: [(String, String)]?, completion: @escaping(Data?) -> Void){
        
        guard var urlComp = URLComponents(string: url) else {
            completion(nil)
            return
        }
        
        var queryArray: [URLQueryItem] = [URLQueryItem]()
        
        if queryDic != nil {
            for queryElement in queryDic!{
                queryArray.append(URLQueryItem.init(name: queryElement.0, value: queryElement.1))
            }
            
            urlComp.queryItems = queryArray
        }
        
        
        guard let formattedURL = urlComp.url else {
            completion(nil)
            return
        }
        
        var urlRequest: URLRequest = URLRequest(url: formattedURL)
        if headerDic != nil {
            for headerElement in headerDic! {
                urlRequest.addValue(headerElement.1, forHTTPHeaderField: headerElement.0)
            }
        }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if(error == nil) {
                if let data = data
                {
                    completion(data)
                }
            } else {
               completion(nil)
            }
        }
        
        task.resume()
    }
    
}
