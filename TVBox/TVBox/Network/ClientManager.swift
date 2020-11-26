//
//  ClientManager.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
class ClientManager {
    func dataRequest<T: Decodable>(with request: Request, responseObjectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        let url = Keys.BaseUrl + request.path
        guard let encodedURL = url.encodedUrl() else {
            completion(Result.failure(ClientError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: encodedURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        if let parameters = request.parameters {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters) {
                urlRequest.httpBody =  jsonData
            }
        }
        urlRequest.httpMethod = request.method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let headers = request.headers {
            for key in headers.keys {
                urlRequest.addValue(headers[key] ?? "", forHTTPHeaderField: key)
            }
        }
        
        let session = DependencyRegistry.sharedInstance.getURLSession()
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard error == nil else {
                completion(Result.failure(ClientError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(ClientError.dataNotFound))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else{
                completion(Result.failure(ClientError.dataNotFound))
                return
            }
            
            guard 200 ..< 300 ~= httpResponse.statusCode else {
                if 401 ..< 404 ~= httpResponse.statusCode {
                    completion(Result.failure(ClientError.unauthorized))
                } else {
                    completion(Result.failure(ClientError.dataNotFound))
                }
                return
            }
            
            do {
                let dataStr = String(data: data, encoding: String.Encoding.utf8)
                //    print(dataStr)
                if  responseObjectType != String.self {
                    let decodedObject = try JSONDecoder().decode(responseObjectType.self, from: data)
                    completion(Result.success(decodedObject))
                }else {
                    completion(Result.success(dataStr as! T))
                }
            } catch let error {
                completion(Result.failure(ClientError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
}
