//
//  MainTabBarController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private lazy var productsViewModel = newProductsViewModel()
    
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
        self.delegate = self
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performLoginFlow()
    }
    
    // MARK: - Setup
    private func setup() {
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        let productsListViewController = ProductsListViewController(productsViewModel: productsViewModel)
        let settingsViewController = SettingsViewController()
        let favoritesViewController = FavoritesViewController(productsViewModel: productsViewModel)
        
        let tabBarViewControllers = [productsListViewController, settingsViewController, favoritesViewController]

        for (i, tabBarItem) in TabBarItem.allCases.enumerated() {
            let item = createBarItem(for: tabBarItem.title)
            let vc = tabBarViewControllers[i]
            vc.tabBarItem = item
        }
        self.viewControllers = tabBarViewControllers
    }
    
    private func createBarItem(for title: String) -> UITabBarItem {
        return UITabBarItem(title: title, image: nil, selectedImage: nil)
    }
    
    
    //MARK: - Login flow
    private func performLoginFlow() {
        if !UserDefaults.isLoggedIn {
            showLoginViewController()
        }
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController(delegate: self)
        loginViewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.present(loginViewController, animated: false)
        }
    }
    
    //MARK: - Factory
    private func newProductsViewModel() -> ProductsViewModel {
        let networkAccess = URLSessionNetworkAccess()
        let productStore = ProductStore()
        let productsViewModel = ProductsViewModel(networkAccess: networkAccess, productStore: productStore)
        return productsViewModel
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
}

extension MainTabBarController: LoginViewControllerDelegate {
    func loginViewControllerDidLogin(_ loginViewController: LoginViewController) {
        UserDefaults.isLoggedIn = true
        self.dismiss(animated: true)
    }
}

enum TabBarItem: CaseIterable {
    case products
    case settings
    case favorites
    
    var title: String {
        switch self {
        case .products: return "Products"
        case .settings: return "Settings"
        case .favorites: return "Favorites"
        }
    }
}
