//
//  ProfileVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 16/05/1443 AH.
//

import UIKit

class ProfileVC: UIViewController {
  
  
  @IBOutlet weak var userName: UILabel!
  
  var text: String?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if text != nil {
      userName.text = text
    }
  }
}
