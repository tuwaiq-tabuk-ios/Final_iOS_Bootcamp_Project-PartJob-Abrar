//
//  LOVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 17/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
  //MARK: - Properties
  let db = Firestore.firestore()
  
  // MARK: - IBOutlets
  @IBOutlet weak var welcomLable: UILabel!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var askLabel: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var createAccountButton: UIButton!
  
  //MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.dismissKeyboard()
    passwordTF.isSecureTextEntry = true
    navigationItem.backButtonTitle = ""
    //localiz()
    
  }
  

  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if isUserIsSignedIn() {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  
  private func isUserIsSignedIn() -> Bool {
    return Auth.auth().currentUser != nil
  }
  
  
  
  
  
  
  
  //MARK: - Action Handlers
  @objc private func startLoginUser() {
    guard let email = emailTF.text else {return}
    guard let password = passwordTF.text else {return}
    print("clicked")
    if !email.isEmpty && !password.isEmpty {
      loginUsing(email: email, password: password)
      
    } else {
      
      let alert = UIAlertController(title: "Oops!".Localized, message: "please make sure email and password are not empty.".Localized, preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
      
      present(alert, animated: true)
    }
    
  }
  
  
  private func loginUsing(email: String, password: String) {
    print("clicked")
    Auth.auth().signIn(withEmail: email, password: password) { results, error in
      
      if let error = error as NSError? {
        switch AuthErrorCode(rawValue: error.code) {
        case .wrongPassword:
          
          let alert = UIAlertController(title: "Oops!".Localized, message: "you entered a wrong password".Localized, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        case .invalidEmail:
          let alert = UIAlertController(title: "Oops!".Localized, message: "are sure you typed the email correctly?", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        default:
          
          let alert = UIAlertController(title: "Oops!".Localized, message: "\(error.localizedDescription)", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        }
      }else{
        guard let user = results?.user else {return}
        
        self.db.collection("Users").document(user.uid).setData([
          "email": String(user.email!),
          "userID": user.uid,
        ], merge: true) { err in
          if let err = err {
            print("Error writing document: \(err)")
          } else {
            print("Document successfully written!")
          }
        }
        
        self.transitionToHome()
      }
    }
  }
  
  
  //MARK: - @IBAction
  
  @IBAction func loginButtonPressed(_ sender: Any){
    
    startLoginUser()
    
  }
  
  func transitionToHome() {
    let controller = self.storyboard?.instantiateViewController(withIdentifier: K.StoryBoard.mainNCScreen) as! UINavigationController
    
    controller.modalPresentationStyle = .fullScreen
    controller.modalTransitionStyle = .flipHorizontal
    self.present(controller, animated: true, completion: nil)
    
  }
}


extension LoginVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    emailTF.resignFirstResponder()
    passwordTF.resignFirstResponder()
    return true
  }
}


