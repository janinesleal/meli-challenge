//
//  ErrorAlert.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit

class ErrorAlertController: UIViewController {
    var type = ErrorType.generic
    
    //MARK: Making components
    
    lazy var customAlert: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 16
        element.layer.masksToBounds = true
        return element
    }()
    
    lazy var dimmedView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .black
        element.alpha = 0.5
        
        return element
    }()
    
    lazy var titleLabel: UILabel = {
        let element = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        element.text = setTitle(type: type)
        element.center = CGPoint(x: 160, y: 285)
        element.textAlignment = .center
        element.tintColor = .black
        element.font = element.font.withSize(30)
        return element
    }()
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(systemName: setImage(type: type))
        element.tintColor = .green
        return element
    }()
    
    lazy var loginButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Logar novamente", for: .normal)
        element.backgroundColor = .magenta
        return element
    }()
    
    private lazy var closeButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(systemName: "xmark"), for: .normal)
        element.tintColor = .black
        element.contentHorizontalAlignment = .right
        element.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        return element
    }()
    
    //MARK: Initialization
    
    init(type: ErrorType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setViews()
        setConstraints()
    }
    
    //MARK: Setting Alert
    
    private func setUpUI() {
        view.backgroundColor = .clear
    }
    
    private func setViews() {
        view.addSubview(dimmedView)
        view.addSubview(customAlert)
        customAlert.addSubview(closeButton)
        customAlert.addSubview(imageView)
        customAlert.addSubview(titleLabel)
        
//        if type == .auth {
//            customAlert.addSubview(loginButton)
//        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            customAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customAlert.heightAnchor.constraint(equalToConstant: 250),
            customAlert.widthAnchor.constraint(equalToConstant: 290),
            
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: customAlert.topAnchor),
            closeButton.bottomAnchor.constraint(equalTo: customAlert.bottomAnchor, constant: -200),
            closeButton.trailingAnchor.constraint(equalTo: customAlert.trailingAnchor, constant: -16),
            closeButton.leadingAnchor.constraint(equalTo: customAlert.leadingAnchor),
            
            imageView.topAnchor.constraint(equalTo: customAlert.topAnchor, constant: 22),
            imageView.bottomAnchor.constraint(equalTo: customAlert.topAnchor, constant: 80),
            imageView.trailingAnchor.constraint(equalTo: customAlert.trailingAnchor, constant: -108),
            imageView.leadingAnchor.constraint(equalTo: customAlert.leadingAnchor, constant: 108),
            
            //TODO: SETAR CONSTRAINTS DO LABEL
//            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 100),
//            titleLabel.bottomAnchor.constraint(equalTo: customAlert.topAnchor, constant: 100),
//            titleLabel.trailingAnchor.constraint(equalTo: customAlert.trailingAnchor, constant: -108),
//            titleLabel.leadingAnchor.constraint(equalTo: customAlert.leadingAnchor, constant: 108),
        ])
    }
    
    private func setTitle(type: ErrorType) -> String {
        switch type {
        case .auth:
            return "Sua sessão expirou!"
        case .category:
            return "Categoria inválida"
        case .generic:
            return "Ops, algo deu errado"
        }
    }
    
    private func setImage(type: ErrorType) -> String {
        switch type {
        case .auth:
            return "person.crop.circle.badge.xmark"
        case .generic:
            return "questionmark.circle"
        case .category:
            return "xmark.circle"
        }
    }
    
    //MARK: Actions
    
    @objc
    func dismissModal() {
        self.dismiss(animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ErrorType {
    case auth, category, generic
}
