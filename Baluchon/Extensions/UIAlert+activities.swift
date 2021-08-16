//
//  UIAlert+activities.swift
//  Baluchon
//
//  Created by Paul Ghibeaux on 14/08/2021.
//

import UIKit

extension UIViewController{
//Show an alert to the user if there is no data coming back from network
    // method to display an alert
    func presentVCAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    
    /// Toggle an activity indicator
    func toggleActivityIndicator(_ indicator: UIActivityIndicatorView, shown: Bool) {
        indicator.isHidden = !shown
    }

}
