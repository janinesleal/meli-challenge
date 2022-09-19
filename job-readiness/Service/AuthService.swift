//
//  AuthService.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

class AuthService {
    let apiClient = APIClient()
    
    func getToken(completion: @escaping ((Result<CertificateRequest, Error>) -> Void)) {
        let body = [
            "client_id" : "1642844960422361",
            "redirect_uri" : "https://www.alkemy.org/",
            "client_secret" : "1EGYKZqkfj6LDjc01TLH39c6cah11cns",
            "code" : "TG-63285dee21ee770001c19aa8-126446547",
            "grant_type" : "authorization_code"
        ]
    
        apiClient.post(urlExtension: .auth, body: body) { result in
            completion(result)
        }
    }
}
