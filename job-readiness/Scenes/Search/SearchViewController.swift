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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = CertificateService()
        let otherserv = SearchService()
        let viewModel = SearchViewModel(certificateService: service, service: otherserv)
//        viewModel.fetchToken()
        viewModel.getCategoryId(category: "Carro")
       
    }


}

