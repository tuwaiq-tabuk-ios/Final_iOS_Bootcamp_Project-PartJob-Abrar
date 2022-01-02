//
//  Ext.UILableCustom.swift
//  DO IT Welcom
//
//  Created by ABRAR ALQARNI on 29/04/1443 AH.
//

import UIKit

extension UILabel {
  func setupLable(titleLabel: String,
                  backgrounC: UIColor,
                  sizeOfText: CGFloat,
                  wightOfText: UIFont.Weight,
                  alignText: NSTextAlignment) {
    
    text = titleLabel
    backgroundColor = backgrounC
    
    font = UIFontMetrics
      .default
      .scaledFont(for: UIFont.systemFont(ofSize: sizeOfText,
                                         weight: wightOfText)
    )
    
    textAlignment = alignText
    
  }
}
