//
//  UIViewController+Utils.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import UIKit

extension UIViewController {
    public func presentInformationAlertController(title: String?, message: String?, okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: String(localized: "OK"), style: .cancel, handler: okActionHandler)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
