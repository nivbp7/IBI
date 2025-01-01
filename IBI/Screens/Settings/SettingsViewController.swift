//
//  SettingsViewController.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

final class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "AppColor")
        self.tabBarController?.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
