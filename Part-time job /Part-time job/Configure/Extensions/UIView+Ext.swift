
//UIView+Extension.swift

import UIKit

extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    get { return self.cornerRadius }
    set {
      self.layer.cornerRadius = newValue
    }
  }
  
}
