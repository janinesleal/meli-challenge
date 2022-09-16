//
//  APIClient.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

class APIClient {
    private let baseURL = "https://api.mercadolibre.com/"
    let urlSession = URLSession.shared
    enum UrlExtension: String {
        case auth = "oauth/token"
        case categoryID = "sites/MLB/domain_discovery/search"
        case productsID = "highlights/MLB/category/"
        case products = "items"
    }
    
    func get<T: Codable>(token: String? = nil,
                         parameters: [String: String]? = nil,
                         urlExtension: String,
                         then handler: @escaping ((Result<T, Error>) -> Void)) {
        
        let url = baseURL + urlExtension
        
        let components = URLComponents(string: url)
        guard var components = components else { return }
        
        if let parameters = parameters {
            components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
       
        let task =  urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            do {
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                
                let response = try JSONDecoder().decode(T.self, from: data)
                handler(Result.success(response))
            } catch {
                handler(Result.failure(error))
                print("error: \(error)")
            }
        }
        
        task.resume()
    }
    
    func post<T: Decodable>(urlExtension: UrlExtension, body: Any, then handler: @escaping ((Result<T, Error>) -> Void)) {
        
        guard let url = URL(string: baseURL + urlExtension.rawValue) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            
            do {
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                
                let response = try JSONDecoder().decode(T.self, from: data)
                handler(Result.success(response))
            } catch {
                handler(Result.failure(error))
                print("API Error")
            }
        }
        
        task.resume()
    }
}
