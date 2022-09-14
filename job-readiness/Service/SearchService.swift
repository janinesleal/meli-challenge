//
//  SearchService.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

class SearchService {
    let apiClient = APIClient()
    
    func getCategoryId(category: String, completion: @escaping (CategoryResponse?) -> ()) {
        //NÃO TEM TOKEN
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
    
    func getProductsIDs(token: String) {
        apiClient.get(token: token, parameters: <#T##[String : String]#>, urlExtension: <#T##String#>, then: <#T##(Data, Error?) -> Void#>)
    }
    //pegar produtos por cateegoria tem token
}
