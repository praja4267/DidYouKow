//
//  ViewController+extensions.swift
//  DidYouKnow
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import UIKit

extension UIViewController {
    @nonobjc func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
