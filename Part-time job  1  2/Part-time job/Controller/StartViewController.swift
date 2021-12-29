//
//  StartViewController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 16/05/1443 AH.
//

import UIKit

class StartViewController: UIViewController {
  
  
  
  @IBOutlet weak var startPressedButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.backButtonTitle = ""
    SetUpStartViewController()
    
  }
}
