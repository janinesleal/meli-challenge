//
//  SearchViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        viewModel.fetchToken()
        viewModel.delegate = self
    }
    
    private func setTableView() {
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.cellID)
    }
    
    @IBAction func searchCategory(_ sender: Any) {
        guard let category = searchTextfield.text else { return }
        
        viewModel.getCategoryId(category: category)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = viewModel.productsList
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsSB") as? DetailsViewController else { return }
        
        viewController.product = list[indexPath.row]
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(110)
    }
    
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellID, for: indexPath) as! ProductTableViewCell
        
        let currentProduct = viewModel.productsList[indexPath.row]
        cell.product = currentProduct
        
        return cell
    }
    
    func showErrorAlert(type: ErrorType) {
        let errorAlert = ErrorAlertController(type: type)
        errorAlert.modalPresentationStyle = .overCurrentContext
        
        self.navigationController?.present(errorAlert, animated: false)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func setViewState(state: SearchViewState) {
        DispatchQueue.main.async {
            switch state {
            case .isLoading:
                print("Is loading")
            case .Success:
                self.resultsTableView.reloadData()
            case .TokenError:
                self.showErrorAlert(type: .auth)
            case .Error:
                self.showErrorAlert(type: .generic)
            case .CategoryError:
                self.showErrorAlert(type: .category)
            }
        }
    }
}
