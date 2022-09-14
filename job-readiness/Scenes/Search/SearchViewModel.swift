//
//  SearchViewModel.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import Foundation

protocol SearchViewModelProtocol {
    var certificateService: CertificateService { get }
    var service: SearchService { get }
    func fetchToken()
    func getCategoryId(category: String)
}

//protocol SearchViewModelDelegate {
//
//}

class SearchViewModel: SearchViewModelProtocol {
    var certificateService: CertificateService
    var service: SearchService
    private var token: String? //Não sei onde salvar
    private var categoryID: String?
    
    init(certificateService: CertificateService, service: SearchService) {
        self.service = service
        self.certificateService = certificateService
    }
    
    func fetchToken() {
        certificateService.getToken { response in
            if let response = response?.access_token {
                self.token = response
                print(self.token)
            } else {
                print(response?.error)
                //TODO: queria que fosse um observável pra daí enviar um status e mostrar o alert - checar amanhã com glauco
            }
        }
    }
    
    func getCategoryId(category: String) {
        service.getCategoryId(category: category) { response in
            if let response = response?.category_id {
                self.categoryID = response
            } else {
                //esse nao tem erro
            }
        }
    }
    
    func getProductsByID() {
        
    }
}
