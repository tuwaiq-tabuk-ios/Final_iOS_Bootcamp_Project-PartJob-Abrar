//
//  CustomToolbarVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 15/05/1443 AH.
//

import UIKit

class CustomToolbarVC: UIViewController {
  
  @IBOutlet weak var userNameTextFiled: UITextField!
  @IBOutlet weak var bioTextFiled: UITextField!
  @IBOutlet weak var pressed: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  
  @IBAction func pressedButon(_ sender: Any) {
    
    let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
    
    controller.text = userNameTextFiled.text
    
    
    controller.modalPresentationStyle = .fullScreen
    present(controller, animated: true, completion: nil)
    
    //    let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.StoryBoard.tabBarController) as? TabBarViewController
    
    //    self.storyboard?.instantiateViewController(identifier: Constants.StoryBoard.profailController) as? ProfileVC
    //    
    //    tabBarController
    
    //    self.view.window?.rootViewController = tabBarController
    //    self.view.window?.makeKeyAndVisible()
    
  }
  
  
  
}
