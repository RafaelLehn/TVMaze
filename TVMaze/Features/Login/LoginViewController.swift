//
//  LoginViewController.swift
//  TVMaze
//
//  Created by Ana Luiza on 3/18/23.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {

    private lazy var loginLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()

    private lazy var passwordLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var passwordTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var loginButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 40
        return view
    }()
    
    private lazy var emailStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        return view
    }()

    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel.delegate = self

        loginLabel.text = "E-mail"
        loginLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        loginLabel.layer.cornerRadius = 10
        loginLabel.layer.masksToBounds = true
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordLabel.layer.cornerRadius = 10
        passwordLabel.layer.masksToBounds = true

        loginTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginTextField.placeholder = "  Enter your e-mail"
        loginTextField.autocapitalizationType = .none
        loginTextField.layer.cornerRadius = 10

        passwordTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        passwordTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.placeholder = "  Enter your password"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.cornerRadius = 10

        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.4297937751, green: 0.7693057656, blue: 0.7303231955, alpha: 1)
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        loginButton.layer.cornerRadius = 10
        
        logoImage.image = UIImage(named: "tv-maze-logo")

        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(logoImage)
        
        mainStackView.addArrangedSubview(emailStackView)
        mainStackView.addArrangedSubview(passwordStackView)
        
        emailStackView.addArrangedSubview(loginLabel)
        emailStackView.addArrangedSubview(loginTextField)
        
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(loginButton)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            
            loginLabel.heightAnchor.constraint(equalToConstant: 30),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 100),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])

    }

    @objc private func login() {
        viewModel.login = loginTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.verifyLogin()
        
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func reject() {
        let myAlertController: UIAlertController = UIAlertController(title: "Hey..!", message: "The login and password field must be filled in!", preferredStyle: .alert)

                //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            
                }
                myAlertController.addAction(cancelAction)
    
        self.present(myAlertController, animated: true, completion: nil)
    }
}


