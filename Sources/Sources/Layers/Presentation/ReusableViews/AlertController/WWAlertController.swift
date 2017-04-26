//
//  WWAlertController.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func alert(with title: String?, message: String?) -> UIAlertController {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okTitle = NSLocalizedString("general.ok", comment: "")
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: nil)
        controller.addAction(okAction)
        
        return controller
    }
}


class WWAlertManager: NSObject {
    
    static func showEmptyUsernameAlert(fromViewController: UIViewController) {
        
        DispatchBlockToMainQueue {
            let title = NSLocalizedString("alert.empty.username.title", comment: "")
            let message = NSLocalizedString("alert.empty.username.message", comment: "")
            let alert = UIAlertController.alert(with: title, message: message)
            
            fromViewController.present(alert, animated: true, completion: nil)
        }
    }
}
