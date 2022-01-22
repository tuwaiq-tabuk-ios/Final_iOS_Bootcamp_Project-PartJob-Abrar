//
//  CreatNew.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 14/06/1443 AH.
//

import UIKit
import Firebase

class CreatNewAccountVC: UIViewController {
  
  
  //MARK: - Properties
  
  let db = Firestore.firestore()
  let categorySegmentedControl = UISegmentedControl (items: ["Employee".Localized,"Employer".Localized])
  var categoryValue = "no"
  
  
  // MARK: - IBOutlets
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var emailTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  @IBOutlet weak var createAccountButton: UIButton!
  @IBOutlet weak var confirmePasswordTF: UITextField!
  
  //MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.backButtonTitle = ""
    passwordTF.isSecureTextEntry = true
    confirmePasswordTF.isSecureTextEntry = true
    navigationController?.navigationBar.barTintColor = UIColor.jobActionColors
    setupUserInterface()
    

    
  }
  
  
  private func setupUserInterface() {
    
    categorySegmentedControl.backgroundColor = .jobBackgroundColor
    categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
    categorySegmentedControl.addTarget(self, action: #selector(self.categoryValueChanged(_:)),
                                       for: .valueChanged)
    self.categorySegmentedControl.selectedSegmentIndex = 0
    
    view.addSubview(categorySegmentedControl)
    
    NSLayoutConstraint.activate([
      categorySegmentedControl.topAnchor.constraint(equalTo: confirmePasswordTF.bottomAnchor, constant: 15),
      categorySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      categorySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      categorySegmentedControl.heightAnchor.constraint(equalToConstant: 30),
      
    ])
    
  }
  
  //MARK: - @IBAction
  @IBAction func createUser(_ sender: UIButton) {
    createNewUser()
  }
  
  
  @objc private func createNewUser() {
    guard let email = emailTF.text else {return}
    guard let password = passwordTF.text else {return}
    guard let name = nameTF.text else {return}
    guard let confirmPassword = confirmePasswordTF.text else {return}
    
    if !email.isEmpty && !password.isEmpty && !name.isEmpty && !confirmPassword.isEmpty  {
      if passwordTF.text == confirmePasswordTF.text {
        createNewUserUsing(email: email, password: password, name: name)
      } else{
        let alert = UIAlertController(title: "Oops!".Localized, message: "Passwords don't Match".Localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
        present(alert, animated: true)
        
      }
    }
    else{
      let alert = UIAlertController(title: "Oops!".Localized, message: "please make sure name, email, password and confirm password  are not empty.".Localized, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
      present(alert, animated: true)
    }
  }
  
  
  func createNewUserUsing(email: String, password: String, name: String) {
    Auth.auth().createUser(withEmail: email, password: password) { results, error in
      
      if let error = error as NSError? {
        switch AuthErrorCode(rawValue: error.code) {
        case .emailAlreadyInUse:
          
          let alert = UIAlertController(title: "Oops!".Localized, message: "email Already in use".Localized, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        case .invalidEmail:
          
          let alert = UIAlertController(title: "Oops!".Localized, message: "are sure you typed the email correctly?".Localized, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        case .weakPassword:
          
          let alert = UIAlertController(title: "Oops!".Localized, message: "Your password is weak, please make sure it's strong.".Localized, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        default:
          
          let alert = UIAlertController(title: "Oops!".Localized, message: "\(error.localizedDescription)", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK".Localized, style: .cancel, handler: nil))
          self.present(alert, animated: true)
          
        }
      } else{
        guard let user = results?.user else {return}
        
        self.db.collection("Users").document(user.uid).setData([
          "name": name,
          "email": String(user.email!),
          "userID": user.uid,
          "isEmployer": self.categoryValue,
        ], merge: true) { err in
          if let err = err {
            print("Error writing document: \(err)")
          } else {
            print("Document successfully written!")
            print("this is userID: \(user.uid)")
            self.transitionToHome()
          }
        }
      }
    }
  }
  
  
  func transitionToHome() {
    let homeViewController = storyboard?.instantiateViewController(identifier: K.StoryBoard.mainNCScreen) as! UINavigationController
    
    view.window?.rootViewController = homeViewController
    view.window?.makeKeyAndVisible()
    present(homeViewController, animated: true, completion: nil)
  }
  
  @objc private func categoryValueChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      categoryValue = "no"
    case 1:
      categoryValue = "yes"
    default:
      break
    }
  }
}

extension CreatNewAccountVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nameTF.resignFirstResponder()
    emailTF.resignFirstResponder()
    passwordTF.resignFirstResponder()
    confirmePasswordTF.resignFirstResponder()
    return true
  }
}
