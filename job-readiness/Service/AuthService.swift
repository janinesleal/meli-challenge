//
//  AuthService.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

class AuthService {
    
    func getToken(completion: @escaping (CertificateRequest?) -> ()) {
        let apiClient = APIClient()
        let body = [
            "client_id" : "1642844960422361",
            "redirect_uri" : "https://www.alkemy.org/",
            "client_secret" : "1EGYKZqkfj6LDjc01TLH39c6cah11cns",
            "code" : "TG-6323188fc4a5860001f575be-126446547",
            "grant_type" : "authorization_code"
        ]
        
        apiClient.post(urlExtension: "oauth/token", body: body) { data, error in
            do {
                let response = try JSONDecoder().decode(CertificateRequest.self, from: data)
                completion(response)
            } catch {
                print(error)
                print("API Error")
            }
        }
    }
}
