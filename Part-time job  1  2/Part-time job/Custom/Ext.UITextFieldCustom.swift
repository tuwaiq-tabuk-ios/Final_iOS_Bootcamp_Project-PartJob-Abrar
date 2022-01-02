//
//  Ext.UITextFieldCustom.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 11/05/1443 AH.
//

import UIKit

extension UITextField {
  
  func setupTextField(_ textfield:UITextField) {
    
    // Create the bottom line
    let bottomLine = CALayer()
    
    bottomLine.frame = CGRect(x: 0,
                              y: textfield.frame.height - 2,
                              width: textfield.frame.width,
                              height: 2)
    
    bottomLine.backgroundColor = UIColor(named: "blue1")?.cgColor
    
    // Remove border on text field
    textfield.borderStyle = .none
    
    // Add the line to the text field
    textfield.layer.addSublayer(bottomLine)
    
  }
  
}
