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
  @IBOutlet var postJobButton: UIButton!
  
  @IBOutlet weak var askAboutJoin: UILabel!
  
  override func viewDidLoad() {
    navigationItem.backButtonTitle = ""
    SetUpJoinController()
    
  }
  
  // MARK: - IBAction
  @IBAction func postJobBtnPressed(_ sender: Any) {
    
    let controller = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.navigationControllerTable) as! UINavigationController
    
    controller.modalPresentationStyle = .fullScreen
    controller.modalTransitionStyle = .flipHorizontal
    present(controller, animated: true, completion: nil)
    
  }
  
}
