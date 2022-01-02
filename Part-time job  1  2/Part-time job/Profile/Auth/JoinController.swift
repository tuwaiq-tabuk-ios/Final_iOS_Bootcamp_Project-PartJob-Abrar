//
//  JoinController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 06/05/1443 AH.
//

import UIKit

class JoinController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet var findAJobButton: UIButton!
  @IBOutlet var businessownerButton: UIButton!
  @IBOutlet weak var askAboutJoin: UILabel!
  
  override func viewDidLoad() {
    navigationItem.backButtonTitle = ""
    SetUpJoinController()
    
  }
  
}
