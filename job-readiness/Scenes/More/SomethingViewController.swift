//
//  SomethingViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 16/09/22.
//

import UIKit

class SomethingViewController: UIViewController {

    lazy var navView: UIView = {
       let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = Colors.yellow
        return element
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        setUpUI()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(navView)
    }
    
    private func setUpUI() {
        view.backgroundColor = .orange
        self.navigationController?.navigationBar.backgroundColor = Colors.yellow
        self.navigationItem.title = ""
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.topAnchor.constraint(equalTo: view.topAnchor),
            navView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 120),
        ])
    }

}
