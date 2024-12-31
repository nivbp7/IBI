//
//  LoginViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit
import Lottie
import LocalAuthentication

final class LoginViewController: UIViewController {
    
    private let username = "IBI"
    private let password = "password"
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let actionButton = UIButton()
    
    private lazy var imageView = newLottieAnimationView()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        startObserving()
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
        authenticateUser()
    }
    
    // MARK: - Observers
    func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stopObserving() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View layout
    private func layout() {
        layoutScrollView()
        layoutTitle()
        layoutTextFields()
        layoutButton()
        layoutImageView()
    }
    
    private func layoutScrollView() {
        scrollView.snap(to: view, shouldAddToView: true)
        contentView.snap(to: scrollView, shouldAddToView: true)
    }
    
    private func layoutTitle() {
        contentView.add(subviews: [titleLabel])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func layoutTextFields() {
        contentView.add(subviews: [usernameTextField, passwordTextField])
        
        NSLayoutConstraint.activate([
            usernameTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func layoutButton() {
        contentView.add(subviews: [actionButton])
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func layoutImageView() {
        contentView.add(subviews: [imageView])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
        ])
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupTitle()
        setupTextField()
        setupButton()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    private func setupTitle() {
        titleLabel.text = "Login Screen"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
    }
    
    private func setupButton() {
        let buttonText = String(localized: "Login")
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        actionButton.backgroundColor = UIColor(red: 21/255, green: 25/255, blue: 73/255, alpha: 1.0)
        actionButton.layer.cornerRadius = 10
    }

    private func setupTextField() {
        let usernameText = String(localized: "Username")
        let passwordText = String(localized: "Password")
        usernameTextField.placeholder = usernameText
        passwordTextField.placeholder = passwordText
        
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
    
    private func authenticateUser() {
        let context = LAContext()
        context.localizedCancelTitle = "Cancel"
        context.localizedFallbackTitle = "Use Passcode"

        let reason = "Authenticate to access your account"
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        print("Authentication Successful!")
                    } else {
                        self.presentInformationAlertController(title: "Failed", message: authenticationError?.localizedDescription)
                    }
                }
            }
        } else {
            self.presentInformationAlertController(title: "Error", message: "Your device does not support this feature")
        }
    }

    // MARK: - Actions
    @objc private func didTapActionButton() {
        validateTextFieldInputs()
    }
    
    @objc private func didTapView() {
        dismissKeyboard()
    }
    
    // MARK: - Helpers
    private func dismissKeyboard() {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - Factory
    private func newLottieAnimationView() -> LottieAnimationView {
        let animationView = LottieAnimationView(name: "login")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }
}

// MARK: - UITextFieldDelegate
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

// MARK: - Keyboard notifications
extension LoginViewController {
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardRectValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRect = keyboardRectValue.cgRectValue
                
                var contentInset = scrollView.contentInset
                contentInset.bottom = keyboardRect.size.height
                scrollView.contentInset = contentInset
            }
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        var contentInset = scrollView.contentInset
        contentInset.bottom = 0.0
        scrollView.contentInset = contentInset
    }
}
