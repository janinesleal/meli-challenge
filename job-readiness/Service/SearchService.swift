//
//  SearchService.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

class SearchService {
    let apiClient = APIClient()
    
    func getCategoryId(category: String, completion: @escaping (CategoryResponse?) -> Void) {
        let params = [
            "limit" : "1",
            "q" : category
        ]
        
        let urlExtension = "sites/MLB/domain_discovery/search"
        
        apiClient.get(parameters: params, urlExtension: urlExtension) { data, error in
            do {
                let category = try JSONDecoder().decode([CategoryResponse].self, from: data)
                completion(category.first)
            } catch let error {
                print("error: \(error)")
            }
        }
    }
    
    func getProductsIDs(token: String, categoryID: String, completion: @escaping (ProductByCategoryResponse?) -> Void) {
        let urlExtension = "/highlights/MLM/category/\(categoryID)"
        
        apiClient.get(token: token, urlExtension: urlExtension) { data, error in
            do {
                let response = try JSONDecoder().decode(ProductByCategoryResponse.self, from: data)
                completion(response)
            } catch let error {
                print("error: \(error)")
            }
        }
    }
}
