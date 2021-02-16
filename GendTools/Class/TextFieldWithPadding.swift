//
//  TextFieldWithPadding.swift
//  AutoLayout
//
//  Created by Pascal Ormancey on 13/02/2021.
//

// Add padding to texfield

import UIKit

@IBDesignable class TextFieldWithPadding: UITextField {
    
    @IBInspectable var textPadding = UIEdgeInsets(
            top: 10,
            left: 5,
            bottom: 10,
            right: 5
        )

        override func textRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.textRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            let rect = super.editingRect(forBounds: bounds)
            return rect.inset(by: textPadding)
        }
}


