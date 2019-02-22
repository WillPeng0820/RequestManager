//
//  RequestManager.swift
//  Coffee
//
//  Created by 彭俊瑋 on 2019/2/22.
//  Copyright © 2019 iOS9487. All rights reserved.
//

import Foundation

class RequestManager: NSObject {
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    static let shareInstance: RequestManager = {
        return RequestManager()
    }()
    
    func sendRequest(request: URLRequest, completion: @escaping(Data?, ErrorModel?) -> Void) {
        
        let urlSessionDataTask = self.session.dataTask(with: request, completionHandler: { (responseData, urlRsponse, error) in
            
            if let failure = error {
                let errorModel = ErrorModel(errorMessage: failure.localizedDescription, errorCode: 999)
                completion(nil, errorModel)
                return
            }
            
            guard let _ = urlRsponse else {
                let errorModel = ErrorModel(errorMessage: "URL Response is nil", errorCode: 998)
                completion(nil, errorModel)
                return
            }
            
            guard (urlRsponse! as! HTTPURLResponse).statusCode == 200 else {
                let errorModel = ErrorModel(errorMessage: "Http Status code is not 200", errorCode: 997)
                completion(nil, errorModel)
                return
            }
            
            completion(responseData, nil)
        })
        urlSessionDataTask.resume()
    }
}
