//
//  SettingsViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

final class SettingsViewController: UIViewController {

    private let segmentedControl = UISegmentedControl(items: ["English", "Hebrew"])
    private let languages = ["en", "he"]
    
    private let logoutButton = UIButton()
    
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
        layoutSegments()
        layoutButton()
    }
    
    private func layoutSegments() {
        view.add(subviews: [segmentedControl])
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func layoutButton() {
        view.add(subviews: [logoutButton])
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupSegments()
        setupButton()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "AppColor")
        self.tabBarController?.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setupSegments() {
        // Configure the segmented control
        segmentedControl.selectedSegmentIndex = getCurrentLanguageIndex()
        segmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
    }
    
    private func setupButton() {
        let title = String(localized: "logout")
        logoutButton.setTitle(title, for: .normal)
        logoutButton.setTitleColor(.label, for: .normal)
        logoutButton.backgroundColor = .systemRed
        logoutButton.layer.cornerRadius = 10
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func logout() {
        UserDefaults.isLoggedIn = false
    }
    
    private func getCurrentLanguageIndex() -> Int {
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        return languages.firstIndex(of: currentLanguage) ?? 0
    }

    @objc private func languageChanged() {
        let selectedLanguage = languages[segmentedControl.selectedSegmentIndex]
        setAppLanguage(selectedLanguage)

        let alert = UIAlertController(title: "Language Changed", message: "Please restart the app to apply the new language.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func setAppLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
