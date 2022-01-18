//
//  TextView.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit

extension UITextView {
  open func setupTextView() {
    backgroundColor = .clear
    autocorrectionType = .no
    layer.cornerRadius = 2
    layer.borderWidth = 1.1
    layer.borderColor = UIColor.gray.cgColor
    clipsToBounds = true
    tintColor = UIColor.gray
    translatesAutoresizingMaskIntoConstraints = false
    
  }
}
