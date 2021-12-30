//
//  SignUPViewController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class SignUPViewController: UIViewController {
  
  
  //MARK: - IBOutlets
  @IBOutlet weak var firstNameTextFiled: UITextField!
  @IBOutlet weak var lastNameTextFiled: UITextField!
  @IBOutlet weak var emaileTextFiled: UITextField!
  @IBOutlet weak var passwordTextFiled: UITextField!
  
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var errorlabel: UILabel!
  
  
  let db = Firestore.firestore()
  
  var  skilledPM: SkilledProfessionalsModel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    SetUpSignUPViewController()
    
  }
  
  
  // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
  func validateFields() -> String? {
    
    // Check that all fields are filled in
    if firstNameTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNameTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emaileTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
      
      return "Please fill in all fields."
    }
    
    // Check if the password is secure
    let cleanedPassword = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if Utilities.isPasswordValid(cleanedPassword) == false {
      // Password isn't secure enough
      return "Please make sure your password is at least 8 characters, contains a special character and a number."
    }
    
    return nil
  }
  
  //MARK: - IBOAction
  
  
  @IBAction func signUpTapped(_ sender: Any) {
    
    // Validate the fields
    let error = validateFields()
    
    if error != nil {
      
      // There's something wrong with the fields, show error message
      showError(error!)
    }
    else {
      
      // Create cleaned versions of the data
      let firstName = firstNameTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let lastName = lastNameTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let email = emaileTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      let password = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
      // Create the user
      Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
        
        // Check for errors
        if err != nil {
          
          // There was an error creating the user
          self.showError("Error creating user")
        }
        else {
          
          // User was created successfully, now store the first name and last name
          let db = Firestore.firestore()
          db.collection("Users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
            
            if error != nil {
              // Show error message
              self.showError("Error saving user data")
            }
          }
          
          // Transition to the home screen
          self.transitionToHome()
        }
      }
    }
  }
  
  func showError(_ message:String) {
    
    errorlabel.text = message
    errorlabel.alpha = 1
  }
  
  func transitionToHome() {
    
    let tabBarController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.tabBarController) as? TabBarViewController
    
    view.window?.rootViewController = tabBarController
    view.window?.makeKeyAndVisible()
    
  }
  
}
