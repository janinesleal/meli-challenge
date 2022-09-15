//
//  SearchViewModel.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import Foundation

protocol SearchViewModelDelegate {
    func setViewState(state: SearchViewState)
}

class SearchViewModel {
    var certificateService = AuthService()
    var service = SearchService()
    var productsList: [ProductResponse] = []
    private var authToken: String? //Não sei onde salvar
    private var categoryID: String?
    private var productsIDList: [String] = []
    var delegate: SearchViewModelDelegate?
    
    
    func fetchToken() {
        certificateService.getToken { response in
            if let response = response?.access_token {
                self.authToken = response
            } else {
                self.delegate?.setViewState(state: .TokenError)
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
            self.delegate?.setViewState(state: .isLoading)
            if let content = response?.content {
                for product in content {
                    guard let id = product.id else { return }
                    self.productsIDList.append(id)
                }
                self.getProducts()
            } else {
                if let error = response?.status {
                    switch error {
                    case 401:
                        self.delegate?.setViewState(state: .TokenError)
                    case 404:
                        self.delegate?.setViewState(state: .Error)
                    default:
                        return
                    }
                }
            }
        }
    }
    
    func getProducts() {
        guard let authToken = authToken else { return }

        service.getProducts(token: authToken, itemsIds: productsIDList) { response in
            if let products = response {
                for product in products {
                    self.productsList.append(product)
                }
                self.delegate?.setViewState(state: .Success)
            } else {
                self.delegate?.setViewState(state: .TokenError)
            }
        }
    }
}

enum SearchViewState {
    case isLoading, TokenError, Error, Success
}
