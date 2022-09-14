//
//  SearchViewModel.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import Foundation

//protocol SearchViewModelProtocol {
////    var certificateService: AuthService { get }
////    var service: SearchService { get }
//    var productsList: [ProductResponse]? { get }
//    func fetchToken()
//    func getCategoryId(category: String)
//    func getProductsByID()
//    func getProducts()
//}

protocol SearchViewModelDelegate {
    func updateTableView()
}

class SearchViewModel {
    var certificateService = AuthService()
    var service = SearchService()
    var productsList: [ProductResponse] = []
    private var authToken: String? //Não sei onde salvar
    private var categoryID: String?
    private var productsIDList: [String] = []
    var delegate: SearchViewModelDelegate?
    
//    init(certificateService: AuthService, service: SearchService) {
//        self.service = service
//        self.certificateService = certificateService
//    }
    
    func fetchToken() {
        certificateService.getToken { response in
            if let response = response?.access_token {
                self.authToken = response
            } else {
                print(response?.error)
                //TODO: queria que fosse um observável pra daí enviar um status e mostrar o alert - checar amanhã com glauco - status 400
            }
        }
    }
    
    func getCategoryId(category: String) {
        service.getCategoryId(category: category) { response in
            if let response = response?.category_id {
                self.categoryID = response
                self.getProductsByID()
            } else {
                //esse nao tem erro - apenas caso api indisponivel
            }
        }
    }
    
    func getProductsByID() {
        guard let authToken = authToken else { return }
        guard let categoryID = categoryID else { return }

        service.getProductsIDs(token: authToken, categoryID: categoryID) { response in
            if let content = response?.content {
                for product in content {
                    guard let id = product.id else { return }
                    self.productsIDList.append(id)
                    
                }
                self.getProducts()
            } else {
                //TODO: mostrar modal de token inválido - status 401
                //TODO: erro de categoria inválida - status 404
            }
        }
    }
    
    func getProducts() {
        guard let authToken = authToken else { return }
        print(self.productsIDList)
        service.getProducts(token: authToken, itemsIds: productsIDList) { response in
            if let products = response {
                for product in products {
                    self.productsList.append(product)
                    print(product.body?.title)
                }
                
                self.delegate?.updateTableView()
            } else {
                //token inválido - stautus 401
            }
        }
    }
}
