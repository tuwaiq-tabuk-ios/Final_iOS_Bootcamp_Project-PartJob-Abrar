//
//  Ext.+ ButtonAleart.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 24/05/1443 AH.
//

import UIKit

extension UIViewController{
  func oneButtonAlert(title: String,
                      message: String) {
    
    let alertController = UIAlertController(title: title,
                                            message: message,
                                            preferredStyle: .alert)
    
    let defaultAction = UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil)
    
    alertController.addAction(defaultAction)
    self.present(alertController,
                 animated: true,
                 completion: nil)
  }
}
