//
//  SettingsViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsViewControllerDidLogout(_ settingsViewController: SettingsViewController)
}

final class SettingsViewController: UIViewController {
    
    weak var delegate: SettingsViewControllerDelegate?

    private let languages = ["en", "he"]
    
    private let languageLabel = UILabel()
    private let displayLabel = UILabel()
    private let languageSegmentedControl = UISegmentedControl(items: ["English", "Hebrew"])
    private let displaySegmentedControl = UISegmentedControl(items: [Appearance.light.title, Appearance.dark.title])
    private let logoutButton = UIButton()
    
    
    // MARK: - Initialization
    init(delegate: SettingsViewControllerDelegate?) {
        self.delegate = delegate
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
        layoutLanguageElements()
        layoutDisplayElements()
        layoutButton()
    }
    
    private func layoutLanguageElements() {
        view.add(subviews: [languageLabel, languageSegmentedControl])
        
        NSLayoutConstraint.activate([
            languageSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            languageSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            languageSegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            languageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: languageSegmentedControl.leadingAnchor, constant: -20),
            languageLabel.centerYAnchor.constraint(equalTo: languageSegmentedControl.centerYAnchor)
        ])
    }
    
    private func layoutDisplayElements() {
        view.add(subviews: [displayLabel, displaySegmentedControl])
        
        NSLayoutConstraint.activate([
            displaySegmentedControl.topAnchor.constraint(equalTo: languageSegmentedControl.bottomAnchor, constant: 20),
            displaySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displaySegmentedControl.widthAnchor.constraint(equalToConstant: 200),
            displayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: displaySegmentedControl.leadingAnchor, constant: -20),
            displayLabel.centerYAnchor.constraint(equalTo: displaySegmentedControl.centerYAnchor)
        ])
    }
    
    private func layoutButton() {
        view.add(subviews: [logoutButton])
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: displaySegmentedControl.bottomAnchor, constant: 100),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Setup
    private func setup() {
        setupView()
        setupLabels()
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
    
    private func setupLabels() {
        languageLabel.text = String(localized: "Language")
        languageLabel.textColor = .label
        
        displayLabel.text = String(localized: "Display")
        displayLabel.textColor = .label
    }
    
    private func setupSegments() {
        languageSegmentedControl.selectedSegmentIndex = getCurrentLanguageIndex()
        languageSegmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        
        displaySegmentedControl.selectedSegmentIndex = getAppearance()
        displaySegmentedControl.addTarget(self, action: #selector(displayModeChanged), for: .valueChanged)
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
        delegate?.settingsViewControllerDidLogout(self)
    }
    
    // MARK: - Language
    private func getCurrentLanguageIndex() -> Int {
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        return languages.firstIndex(of: currentLanguage) ?? 0
    }

    @objc private func languageChanged() {
        let selectedLanguage = languages[languageSegmentedControl.selectedSegmentIndex]
        setAppLanguage(selectedLanguage)

        let alert = UIAlertController(title: "Language Changed", message: "Please restart the app to apply the new language.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func setAppLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Appearance
    private func getAppearance() -> Int {
        let appearanceString = UserDefaults.applicationAppearance
        let appearance = Appearance(rawValue: appearanceString) ?? Appearance.defaultAppearance
        return appearance.index
    }
    
    @objc private func displayModeChanged() {
        let appearance = Appearance.at(displaySegmentedControl.selectedSegmentIndex)
        UserDefaults.applicationAppearance = appearance.rawValue
        
        if appearance == .dark {
            self.view.window?.overrideUserInterfaceStyle = .dark
        } else {
            self.view.window?.overrideUserInterfaceStyle = .light
        }
    }
}

enum Appearance: String, CaseIterable {
    case light
    case dark
    
    var title: String {
        switch self {
        case .light: return String(localized: "Light")
        case .dark: return String(localized: "Dark")
        }
    }
    
    static var defaultAppearance: Appearance {
        return .light
    }
    
    static var titles: [String] {
        return Self.allCases.map({$0.title})
    }
    
    var index: Self.AllCases.Index {
        if let index = Self.allCases.firstIndex(where: {self == $0}) {
            return index
        }
        else{
            return 0
        }
    }
    
    static func at(_ index: Int) -> Appearance {
        return Appearance.allCases[index]
    }
}

extension Appearance {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
