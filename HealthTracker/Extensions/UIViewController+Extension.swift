//
//  UIViewController+Extension.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import Foundation
import UIKit
import Toast_Swift

extension UIViewController {
    func showAlert(title: String? = nil, message: String, actions: [UIAlertAction] = []) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if actions.isEmpty {
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
            } else {
                for action in actions {
                    alert.addAction(action)
                }
            }
            self?.present(alert, animated: true)
        }
    }
}

extension UIViewController {
    func showToastMessage(message: String) {
        if message.isEmpty { return }
        view.makeToast(message, position: .bottom)
    }

    func showCenterToastMessage(message: String) {
        if message.isEmpty { return }
        view.makeToast(message, position: .center)
    }
}

extension UINavigationController {
    
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}
