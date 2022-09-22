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
    var mainView: HomeView { return self.view as! HomeView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setDelegates()
        viewModel.fetchToken()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = mainView.productsTableView.indexPathForSelectedRow {
            mainView.productsTableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    private func setDelegates() {
        viewModel.delegate = self
        mainView.searchBar.delegate = self
        mainView.productsTableView.delegate = self
        mainView.productsTableView.dataSource = self
    }
    
    private func setUpUI() {
        navigationItem.titleView = mainView.searchBar
        let rightNavBarButton = mainView.cartButton
        navigationItem.rightBarButtonItem = rightNavBarButton
        
    }
    
    //MARK: ACTIONS
    func showErrorAlert(type: ErrorType) {
        let errorAlert = ErrorAlertController(type: type)
        errorAlert.modalPresentationStyle = .overCurrentContext
        
        navigationController?.present(errorAlert, animated: false)
    }
    
    func createLoadingView() {
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
        mainView.searchBar.endEditing(true)
    }
}

//MARK: EXTENSIONS
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.category = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel.getCategoryId()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = viewModel.productsList
        
        let viewController =  DetailsViewController()
        
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
        let cell = mainView.productsTableView.dequeueReusableCell(withIdentifier: CellIdsStrings.productTV.rawValue, for: indexPath) as! ProductTableViewCell
        
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
                self.mainView.productsTableView.reloadData()
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
