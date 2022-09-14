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
        setUpUI()
        viewModel.fetchToken()
        viewModel.delegate = self
    }
    
    private func setTableView() {
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "productCell")
    }
    
    private func setUpUI() {
        //        let searchBtn = UIButton(type: .custom)
        //        searchBtn.addTarget(self, action: #selector(self.searchCategory), for: .touchUpInside)
        //        searchBtn.frame = CGRect(x: CGFloat(searchTextfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //        searchBtn.setImage(UIImage(systemName: "search"), for: .normal)
        //
        //        let button = UIButton(type: .custom)
        //        button.setImage(UIImage(systemName: "search"), for: .normal)
        //        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        //        button.frame = CGRect(x: CGFloat(searchTextfield.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //        button.addTarget(self, action: #selector(self.searchCategory), for: .touchUpInside)
        //
        //        searchTextfield.addSubview(searchBtn)
        //        searchTextfield.rightView = button
        //        searchTextfield.rightViewMode = .always
    }
    
    @IBAction func searchCategory(_ sender: Any) {
        guard let category = searchTextfield.text else { return }
        
        viewModel.getCategoryId(category: category)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if let list = viewModel?.categoriesList {
        //            selectedType = list[indexPath.row]
        //            pushToSuggestionPage()
        //        }
        print("Clicou")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        
        let list = viewModel.productsList
        
        cell.setCell(title: list[indexPath.row].body?.title ?? "deu ruim", price: "\(list[indexPath.row].body?.price ?? 0)")
        
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
