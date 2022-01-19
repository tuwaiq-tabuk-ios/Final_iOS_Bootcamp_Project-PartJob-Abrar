//
//  EditVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 14/06/1443 AH.
//

import UIKit
import Firebase

class EditVC: UIViewController {
  
  //  MARK: - Properties
  private let db = Firestore.firestore()
  
  //  MARK: - @IBOutlet
  private let nameHeader: UILabel = {
      let lbl = UILabel()
      lbl.textColor = .black.withAlphaComponent(0.57)
      lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
      lbl.translatesAutoresizingMaskIntoConstraints = false
      lbl.text = "Your name"
      return lbl
  }()
  
  private let nameTF: UITextField = {
      let textField = UITextField()
      textField.setupTextField(with:  NSAttributedString(string: "Ex: Abrar",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
      return textField
  }()

  private let degreeHeader: UILabel = {
      let lbl = UILabel()
      lbl.textColor = .black.withAlphaComponent(0.57)
      lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
      lbl.translatesAutoresizingMaskIntoConstraints = false
      lbl.text = "Your degree"
      return lbl
  }()
  private let degreeTF: UITextField = {
      let textField = UITextField()
      textField.setupTextField(with:  NSAttributedString(string: "Ex: Bachelor in Computer Engineering",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
      return textField
  }()
  
  private let ageHeader: UILabel = {
      let lbl = UILabel()
      lbl.textColor = .black.withAlphaComponent(0.57)
      lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
      lbl.translatesAutoresizingMaskIntoConstraints = false
      lbl.text = "Your age"
      return lbl
  }()
  
  private let ageTF: UITextField = {
      let textField = UITextField()
      textField.setupTextField(with:  NSAttributedString(string: "Ex: 26 years old",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
      return textField
  }()
  
  private let experienceHeader: UILabel = {
      let lbl = UILabel()
      lbl.textColor = .black.withAlphaComponent(0.57)
      lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
      lbl.translatesAutoresizingMaskIntoConstraints = false
      lbl.text = "Your experience"
      return lbl
  }()
  
  private let experienceTF: UITextField = {
      let textField = UITextField()
      textField.setupTextField(with:  NSAttributedString(string: "Ex: 2~ years",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
      return textField
  }()
  
  ///Buttun

  private let done: UIButton = {
      let btn = UIButton(type: .system)
    btn.setImage(UIImage(systemName: "paperplane.fill")!.withTintColor(.gray).withRenderingMode(.alwaysOriginal), for: .normal)
      btn.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
  }()
  
  //  MARK: - View controller life cycle
  override func viewDidLoad() {
      super.viewDidLoad()
    
      // Do any additional setup after loading the view.
      title = "Edit"
      
      setupPresenetationMode()
      setupViews()
  }

  
//متاحه بس في 15
  private func setupPresenetationMode() {
    if #available(iOS 15.0, *) {
      if let presentationController = presentationController as? UISheetPresentationController {
        presentationController.detents = [
          .medium(),
          .large()
        ]
        presentationController.prefersGrabberVisible = true
      }
    } else {
      // Fallback on earlier versions
    }
  }
  
  
  private func setupViews() {
      view.addSubview(nameHeader)
      view.addSubview(nameTF)
      view.addSubview(experienceHeader)
      view.addSubview(experienceTF)
      view.addSubview(degreeHeader)
      view.addSubview(degreeTF)
      view.addSubview(ageHeader)
      view.addSubview(ageTF)
      view.addSubview(done)
      
      nameTF.delegate = self
      experienceTF.delegate = self
      degreeTF.delegate = self
      ageTF.delegate = self
      
      NSLayoutConstraint.activate([
      
      
          done.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
          done.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          
          nameHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
          nameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         
          
          nameTF.topAnchor.constraint(equalTo: nameHeader.bottomAnchor, constant: 10),
          nameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          nameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          nameTF.heightAnchor.constraint(equalToConstant: 45),
          
          
          experienceHeader.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 20),
          experienceHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          experienceHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          
          experienceTF.topAnchor.constraint(equalTo: experienceHeader.bottomAnchor, constant: 10),
          experienceTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          experienceTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          experienceTF.heightAnchor.constraint(equalToConstant: 45),
      
          degreeHeader.topAnchor.constraint(equalTo: experienceTF.bottomAnchor, constant: 20),
          degreeHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          degreeHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          
          degreeTF.topAnchor.constraint(equalTo: degreeHeader.bottomAnchor, constant: 10),
          degreeTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          degreeTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          degreeTF.heightAnchor.constraint(equalToConstant: 45),
      
      
          ageHeader.topAnchor.constraint(equalTo: degreeTF.bottomAnchor, constant: 20),
          ageHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          ageHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          
          ageTF.topAnchor.constraint(equalTo: ageHeader.bottomAnchor, constant: 10),
          ageTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
          ageTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
          ageTF.heightAnchor.constraint(equalToConstant: 45),
      
      ])
  }

  @objc private func doneTapped() {
      guard let user = Auth.auth().currentUser else {return}
      
      guard let name = nameTF.text,
            let exp = experienceTF.text,
            let degree = degreeTF.text,
            let age = ageTF.text
      else {return}
      
      if name.isEmpty || age.isEmpty || exp.isEmpty || degree.isEmpty || age.isEmpty {
          let alert = UIAlertController(title: "Error", message: "please fill out all the required fields", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }else{
          self.db.collection("Users").document(user.uid).updateData([
              "name": name,
              "age": age,
              "exp": exp,
              "degree": degree,
          ])
      }
      
  }
}


extension EditVC: UITextFieldDelegate {
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
      nameTF.resignFirstResponder()
      ageTF.resignFirstResponder()
      experienceTF.resignFirstResponder()
      degreeTF.resignFirstResponder()
      return true
  }
}
