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
        certificateService.getToken { result in
            switch result {
            case let .success(response):
                if let response = response.access_token {
                    self.authToken = response
                } else {
                    self.delegate?.setViewState(state: .TokenError)
                }
            case .failure(_):
                self.delegate?.setViewState(state: .Error)
            }
        }
    }
    
    func getCategoryId(category: String) {
        service.getCategoryId(category: category) { result in
            self.delegate?.setViewState(state: .isLoading)
            
            switch result {
            case let .success(response):
                if let response = response.first?.category_id {
                    self.categoryID = response
                    self.getProductsByID()
                }
            case .failure(_):
                self.delegate?.setViewState(state: .Error)
            }
        }
    }
    
    func getProductsByID() {
        guard let authToken = authToken else { return }
        guard let categoryID = categoryID else { return }
        
        service.getProductsIDs(token: authToken, categoryID: categoryID) { result in
            switch result {
            case let .success(response):
                if let content = response.content {
                    for product in content {
                        guard let id = product.id else { return }
                        self.productsIDList.append(id)
                    }
                    self.getProducts()
                } else {
                    if let error = response.status {
                        switch error {
                        case 401:
                            self.delegate?.setViewState(state: .TokenError)
                        case 404:
                            self.delegate?.setViewState(state: .CategoryError)
                        default:
                            return
                        }
                    }
                }
            case .failure(_):
                self.delegate?.setViewState(state: .Error)
            }
        }
    }
    
    func getProducts() {
        guard let authToken = authToken else { return }
        
        service.getProducts(token: authToken, itemsIds: productsIDList) { result in
            switch result {
            case let .success(response):
                if let products = response {
                    for product in products {
                        self.productsList.append(product)
                    }
                    self.delegate?.setViewState(state: .Success)
                } else {
                    self.delegate?.setViewState(state: .TokenError)
                }
            case .failure(_):
                self.delegate?.setViewState(state: .Error)
            }
        }
    }
}

enum SearchViewState {
    case isLoading, TokenError, CategoryError, Success, Error
}
