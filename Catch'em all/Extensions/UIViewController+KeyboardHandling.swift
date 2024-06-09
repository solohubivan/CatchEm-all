//
//  UIViewController+KeyboardHandling.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 30.05.2024.
//

import UIKit

extension UIViewController {
    
    func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = .zero
    }
}
