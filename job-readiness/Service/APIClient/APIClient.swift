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
    
    func get(token: String, parameters: [String: String], urlExtension: String, then handler: @escaping (Data, Error?) -> Void) {
        let url = baseURL + urlExtension
        
        let components = URLComponents(string: url)
        guard var components = components else { return }

        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
   
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task =  urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            handler(data, error)
        }
        
        task.resume()
    }
    
    func get(token: String, urlExtension: String, then handler: @escaping (Data, Error?) -> Void) {
        guard let url = URL(string: baseURL + urlExtension) else { return }
    
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task =  urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            handler(data, error)
        }
        
        task.resume()
    }
    
    func get(parameters: [String: String], urlExtension: String, then handler: @escaping (Data, Error?) -> Void) {
        let url = baseURL + urlExtension
        
        let components = URLComponents(string: url)
        guard var components = components else { return }

        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else { return }
        let request = URLRequest(url: url)
        
        let task =  urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            print(data)
            handler(data, error)
        }
        
        task.resume()
    }
    
    func post(urlExtension: String, body: Any, then handler: @escaping (Data, Error?) -> Void) {
        
        guard let url = URL(string: baseURL + urlExtension) else {
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
            
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            handler(data, error)
        }
        
        task.resume()
    }
}
