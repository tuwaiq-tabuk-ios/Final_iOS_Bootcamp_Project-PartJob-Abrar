//
//  BOLoginVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 27/05/1443 AH.
//

import UIKit
import FirebaseAuth

class BOLoginVC: UIViewController {

  //MARK: - IBOutlets
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        
        emailTextField.setupTextField(emailTextField)
        passwordTextField.setupTextField(passwordTextField)
        

    
  }
  
  //MARK: - IBOAction
  
  @IBAction func loginTapped(_ sender: Any) {
    
    // TODO: Validate Text Fields
    
    // Create cleaned versions of the text field
    let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    // Signing in the user
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      
      if error != nil {
        // Couldn't sign in
        self.errorLabel.text = error!.localizedDescription
        self.errorLabel.alpha = 1
      }
      else {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.navigationControllerTable) as! UINavigationController
        
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
      }
    }
    
  }
  
}
