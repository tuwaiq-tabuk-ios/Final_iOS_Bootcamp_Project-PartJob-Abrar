//
//  TextFields.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 20/05/1443 AH.
//

import UIKit

extension UITextField {
  open func setupTextField(with placeholder: NSAttributedString) {
    backgroundColor = .clear
    autocorrectionType = .no
    layer.cornerRadius = 15
    layer.borderWidth = 1.1
    layer.borderColor = UIColor(named: "offWhite")?.cgColor
    clipsToBounds = true
    leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
    leftViewMode = .always
    attributedPlaceholder = placeholder
    tintColor = .jobActionColors
    textColor = .jobText
    translatesAutoresizingMaskIntoConstraints = false
  }
  
}
