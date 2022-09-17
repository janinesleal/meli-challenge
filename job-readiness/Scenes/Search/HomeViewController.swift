//
//  HomeViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setViews()
        setConstraints()
    }
    
    private func setUpUI() {
        view.backgroundColor = .purple
    }
    
    private func setViews() {
        self.navigationItem.titleView = searchBar
        searchBar.backgroundColor = .clear
        view.addSubview(searchView)
        searchBar.delegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 120),
        ])
    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Clicou")
    }
}
