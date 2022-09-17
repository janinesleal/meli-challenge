//
//  LoadingViewController.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 17/09/22.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)

        override func loadView() {
            view = UIView()
            view.backgroundColor = .clear

            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.startAnimating()
            view.addSubview(spinner)

            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }

}
