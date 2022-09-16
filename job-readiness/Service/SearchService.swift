//
//  SearchService.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

protocol SearchServiceProtocol {
    func getCategoryId(category: String, completion: @escaping ((Result<[CategoryResponse], Error>) -> Void))
    func getProductsIDs(token: String, categoryID: String, completion: @escaping ((Result<ProductByCategoryResponse, Error>) -> Void))
    func getProducts(token: String, itemsIds: [String], completion: @escaping ((Result<[ProductResponse]?, Error>) -> Void))
}

class SearchService: SearchServiceProtocol {
    let apiClient = APIClient()
    
    func getCategoryId(category: String, completion: @escaping ((Result<[CategoryResponse], Error>) -> Void)) {
        let params = [
            "limit" : "1",
            "q" : category
        ]
        let urlExtension = "sites/MLB/domain_discovery/search"
        
        apiClient.get(parameters: params, urlExtension: urlExtension) { result in
            completion(result)
        }
    }
    
    func getProductsIDs(token: String, categoryID: String, completion: @escaping ((Result<ProductByCategoryResponse, Error>) -> Void)) {
        let urlExtension = "highlights/MLB/category/\(categoryID)"
        
        apiClient.get(token: token, urlExtension: urlExtension) { result in
            completion(result)
        }
    }
    
    func getProducts(token: String, itemsIds: [String], completion: @escaping ((Result<[ProductResponse]?, Error>) -> Void)) {
        
        let params = [
            "ids" : itemsIds.joined(separator: ",")
        ]
        
        let urlExtension = "items"
        
        apiClient.get(token: token, parameters: params, urlExtension: urlExtension) { response in
            completion(response)
        }
    }
}
