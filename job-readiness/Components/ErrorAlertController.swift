//
//  ErrorAlert.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 12/09/22.
//

import UIKit

class ErrorAlertController: UIViewController {
    var type = ErrorType.generic
    
    //MARK: Components
    
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
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = setTitle(type: type)
        element.textAlignment = .center
        element.tintColor = .lightGray
        element.font = UIFont(name: Font.medium, size: 17)
        return element
    }()
    
    lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(systemName: setImage(type: type))
        element.tintColor = Colors.darkBlue
        return element
    }()
    
    lazy var loginButton: UIButton = {
        let btnTitle = NSMutableAttributedString(string: "Fazer login", attributes:[
            NSAttributedString.Key.font: UIFont(name: Font.regular, size: 14) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            ])
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setAttributedTitle(btnTitle, for: .normal)
        element.backgroundColor = Colors.darkBlue
        element.layer.cornerRadius = 16
        return element
    }()
    
    private lazy var closeButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(systemName: Icons.close.rawValue), for: .normal)
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
        
        if type == .auth {
            customAlert.addSubview(loginButton)
        }
    }
    
    //MARK: Setting constraints
    
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
            imageView.leadingAnchor.constraint(equalTo: customAlert.leadingAnchor, constant: 118),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: customAlert.centerXAnchor),
        ])
        
        if type == .auth {
            NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: customAlert.bottomAnchor, constant: -80),
            loginButton.centerXAnchor.constraint(equalTo: customAlert.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 35),
            loginButton.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
            ])
        }
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
            return Icons.noAuth.rawValue
        case .generic:
            return Icons.genericError.rawValue
        case .category:
            return Icons.error.rawValue
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
