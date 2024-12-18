//
//  UITextField+Extension.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//


import Foundation
import UIKit

extension UITextField {
    @IBInspectable
    var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}

class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            //print("not allowed to paste")
            return true
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

// used for maxlenght textfiled start

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }

    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }
        let selection = selectedTextRange
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        selectedTextRange = selection
    }
}
