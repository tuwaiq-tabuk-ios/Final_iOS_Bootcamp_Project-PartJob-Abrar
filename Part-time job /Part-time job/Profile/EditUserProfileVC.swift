//
//  EditeUserProfileVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 29/05/1443 AH.
//

import UIKit
import Firebase
//import Contacts
import FirebaseFirestore

class EditUserProfileVC: UIViewController {

  // MARK: - @IBOutlet
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var genderTextField: UITextField!
  @IBOutlet weak var countryTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var skillsTextField: UITextField!

  @IBOutlet weak var userEmailTextFiled: UITextField!
  @IBOutlet weak var userPasswordTextField: UITextField!
  @IBOutlet weak var userConfirmPasswordTextField: UITextField!

  @IBOutlet weak var userImageView: UIImageView!
  //  {
  //    didSet{
  //
  //        userImageView.isUserInteractionEnabled = true
  //        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectimage))
  //        userImageView.addGestureRecognizer(tabGesture)
  //    }
  //}


  let db = Firestore.firestore()
  

  var name = "name"
  var gender = "gender"
  var country = "country"
  var age = "age"
  var skills = "skills"
  var email = ""
  var image = "image"


  override func viewDidLoad() {
    super.viewDidLoad()


  }




  // MARK: - @IBAction
  @IBAction func addProfilPhotoBtn(_ sender: UIButton) {


  }




  @IBAction func saveInfoBtn(_ sender: Any) {
    
    //Adding a document
        let db = db.collection("Users").document(Auth.auth().currentUser!.uid).updateData([
        "name": self.nameTextField.text!,
          "gender": self.genderTextField.text!,
          "country" : self.countryTextField.text!,
          "age": self.ageTextField.text!,
          "skills" : self.skillsTextField.text!,
          "email" : self.userEmailTextFiled.text!,
    ])
    { err in
           if let err = err {
            print("\n\n\n -- error updating document: \(err)")
           } else {
            print("\n\n\n -- Data Upload")
           }
          }
    
  }
}
