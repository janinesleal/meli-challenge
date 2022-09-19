//
//  HomeViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: COMPONENTS
    var viewModel = HomeViewModel()
    lazy var loadingViewController = LoadingViewController()
    var category: String?
    
    lazy var searchView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.yellow
        return element
    }()
    
    lazy var cartButton: UIBarButtonItem = {
        let element = UIBarButtonItem()
        element.image = UIImage(systemName: Icons.cart.rawValue)
        element.tintColor = .darkGray
        return element
    }()
    
    lazy var searchBar: UISearchBar = {
        let element = UISearchBar()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.placeholder = "Buscar no Mercado Livre"
        element.searchTextField.backgroundColor = .white
        element.searchTextField.clipsToBounds = true
        element.searchTextField.layer.cornerRadius = 16
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
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.productsTableView.indexPathForSelectedRow{
            self.productsTableView.deselectRow(at: index, animated: true)
        }
    }
    
    private func setViews() {
        view.addSubview(searchView)
        searchBar.delegate = self
        
        viewModel.delegate = self
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: CellIdsStrings.productTV.rawValue)
        view.addSubview(productsTableView)
    }
    
    private func setUpUI() {
        self.navigationItem.titleView = searchBar
        let rightNavBarButton = cartButton
        self.navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    //MARK: CONSTRAINTS
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
    
    //MARK: ACTIONS
    func showErrorAlert(type: ErrorType) {
        let errorAlert = ErrorAlertController(type: type)
        errorAlert.modalPresentationStyle = .overCurrentContext
        
        self.navigationController?.present(errorAlert, animated: false)
    }
    
    func createLoadingView() {
        // add the spinner view controller
        addChild(loadingViewController)
        loadingViewController.view.frame = view.frame
        view.addSubview(loadingViewController.view)
        loadingViewController.didMove(toParent: self)
    }
    
    func removeLoadingView() {
        loadingViewController.willMove(toParent: nil)
        loadingViewController.view.removeFromSuperview()
        loadingViewController.removeFromParent()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
    }
}

//MARK: EXTENSIONS
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
        let storyboard = UIStoryboard(name: StoryboardsStrings.main.rawValue, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: StoryboardsStrings.detailsSBID.rawValue) as? DetailsViewController else { return }
        
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
        let cell = productsTableView.dequeueReusableCell(withIdentifier: CellIdsStrings.productTV.rawValue, for: indexPath) as! ProductTableViewCell
        
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
                self.createLoadingView()
            case .Success:
                self.removeLoadingView()
                self.productsTableView.reloadData()
            case .TokenError:
                self.removeLoadingView()
                self.showErrorAlert(type: .auth)
            case .Error:
                self.removeLoadingView()
                self.showErrorAlert(type: .generic)
            case .CategoryError:
                self.removeLoadingView()
                self.showErrorAlert(type: .category)
            }
        }
    }
}
