//
//  LoginViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let username = "IBI"
    private let password = "password"
    
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - View layout
    private func layout() {
        layoutTextFields()
    }
    
    private func layoutTextFields() {
        view.add(subviews: [usernameTextField, passwordTextField])
        
        NSLayoutConstraint.activate([
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupTextField()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTextField() {
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        
        passwordTextField.textColor = .label
        usernameTextField.textColor = .label
        
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        usernameTextField.returnKeyType = .next
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.textContentType = .username
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.delegate = self
        
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.textContentType = .password
        passwordTextField.delegate = self
    }
    
    // MARK: - Validation
    @objc private func validateTextFieldInputs() {
        dismissKeyboard()
        guard let username = usernameTextField.text, let password = passwordTextField.text, !username.trim.isEmpty, !password.trim.isEmpty else {
            presentInformationAlertController(title: "Missing username or password", message: "Please enter your username and password")
            return
        }
        guard username == self.username, password == self.password else {
            presentInformationAlertController(title: "Incorrect username or password", message: "Please enter a valid username and password")
            return
        }
        
        print("Login successful")
    }
    
    // MARK: - Helpers
    private func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
            return false
        }
        else if textField == passwordTextField {
            validateTextFieldInputs()
            return true
        }
        return true
    }
}
