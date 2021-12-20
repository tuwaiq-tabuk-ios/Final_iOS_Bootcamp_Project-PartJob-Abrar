//
//  JoinController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 06/05/1443 AH.
//

import UIKit

class JoinController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet var asCompany: UIButton!
  @IBOutlet var asEmployee: UIButton!
  
  @IBOutlet weak var askAboutJoin: UILabel!
  
  override func viewDidLoad() {
    navigationItem.backButtonTitle = ""
    SetUpJoinController()
    
  }
  
  
}
