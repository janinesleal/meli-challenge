//
//  HomeViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    var category: String?
    
    lazy var searchView: UIView = {
       let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.yellow
        return element
    }()
    
    lazy var searchBar: UISearchBar = {
        let element = UISearchBar()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.searchBarStyle = .minimal
        return element
    }()
    
    lazy var productsTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.rowHeight = UITableView.automaticDimension
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setUpUI()
        setConstraints()
        viewModel.fetchToken()
    }
    
    private func setViews() {
        view.addSubview(searchView)
        searchBar.delegate = self
        
        viewModel.delegate = self
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.cellID)
        view.addSubview(productsTableView)
    }
    
    private func setUpUI() {
        view.backgroundColor = .purple
        self.navigationItem.titleView = searchBar
        searchBar.backgroundColor = .clear
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            productsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            productsTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            productsTableView.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 120),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func showErrorAlert(type: ErrorType) {
        let errorAlert = ErrorAlertController(type: type)
        errorAlert.modalPresentationStyle = .overCurrentContext
        
        self.navigationController?.present(errorAlert, animated: false)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        category = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let category = searchBar.text else { return }
        searchBar.endEditing(true)
        viewModel.getCategoryId(category: category)
    }
}

extension HomeViewController: UITableViewDelegate {
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellID, for: indexPath) as! ProductTableViewCell
        
        let currentProduct = viewModel.productsList[indexPath.row]
        cell.product = currentProduct
        
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func setViewState(state: HomeViewState) {
        DispatchQueue.main.async {
            switch state {
            case .isLoading:
                print("Is loading")
            case .Success:
                self.productsTableView.reloadData()
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
