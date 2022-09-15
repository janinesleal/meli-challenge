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
        resultsTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCell")
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
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        
        if let product = viewModel.productsList[indexPath.row].body {
            cell.setCell(title: product.title ?? "",
                         price: product.price ?? 0,
                         image: product.thumbnail ?? "")
        }
        
        return cell
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func updateTableView() {
        DispatchQueue.main.async { [self] in
            resultsTableView.reloadData()
        }
    }
}
