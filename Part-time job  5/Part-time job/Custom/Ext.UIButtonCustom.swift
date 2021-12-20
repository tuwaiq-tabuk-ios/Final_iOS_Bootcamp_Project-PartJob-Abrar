//
//  Ext.UIButton.swift
//  DO IT Welcom
//
//  Created by ABRAR ALQARNI on 29/04/1443 AH.
//

import UIKit

extension UIButton{
  
  func setupButton(title: String,
                   sizeOfText: CGFloat,
                   wightOfText: UIFont.Weight,
                   titleColor: UIColor,
                   cornerRad: CGFloat)
  {
    
    setTitle(title, for: .normal)
    titleLabel?.font =
    UIFontMetrics.default.scaledFont(for:UIFont.systemFont(ofSize: sizeOfText,
                                                           weight: wightOfText))
    setTitleColor(titleColor,
                  for: .normal)
    layer.cornerRadius = cornerRad
    clipsToBounds = true
  }
}
