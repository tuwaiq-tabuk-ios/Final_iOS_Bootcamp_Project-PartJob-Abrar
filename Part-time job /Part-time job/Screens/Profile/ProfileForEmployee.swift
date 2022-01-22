//
//  ProfileForEmployee.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit
import Firebase

class ProfileForEmployee: UIViewController {
  
  //  MARK: - Properties
  let db = Firestore.firestore()
  var user: User?
  
  //  MARK: - @IBOutlet
  private let nameHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Name: ".Localized
    return lbl
  }()
  
  
  private let nameLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  private let emailHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Email: ".Localized
    return lbl
  }()
  
  
  private let emailLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    lbl.textAlignment = .left
    return lbl
  }()
  
  private let ageHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Age: ".Localized
    return lbl
  }()
  
  
  private let ageLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  private let degreeHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Degree: ".Localized
    return lbl
  }()
  
  
  private let degreeLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  private let experienceHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Experience: ".Localized
    return lbl
  }()
  
  
  private let experienceLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  //  MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Profile".Localized
    view.backgroundColor = .jobBackgroundColor
    navigationItem.largeTitleDisplayMode = .never
    setupViews()
    
    let editButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    editButton.setImage(UIImage(systemName: "highlighter")!.withTintColor(.jobActionColors!).withRenderingMode(.alwaysOriginal), for: .normal)
    editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    
    
    let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    logoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!.withTintColor(.systemRed.withAlphaComponent(0.57)).withRenderingMode(.alwaysOriginal), for: .normal)
    logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: logoutButton), UIBarButtonItem(customView: editButton)]
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getUserData()
  }
  
  //MARK: -
  @objc private func editButtonTapped() {
    let sheetViewController = EditEmployeeProfileVC()
    self.present(sheetViewController, animated: true, completion: nil)
  }
  
  //Alert
  @objc private func logout() {
    let alert = UIAlertController(title: "Log out".Localized, message: "Your sure you want to log out?".Localized,
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "LOG OUT".Localized, style: .destructive,
                                  handler: { _ in
      do {
        try Auth.auth().signOut()
        self.dismiss(animated: true, completion:nil)

      }
      catch let signOutError {
        let alert = UIAlertController(title: "Error".Localized, message: signOutError.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
      }

    }))

    alert.addAction(UIAlertAction(title: "CANCEL".Localized, style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)

   
      }
    
  
  
  func getUserData() {
    guard let user = Auth.auth().currentUser else {return}
    
    db.collection("Users").whereField("userID", isEqualTo: user.uid).addSnapshotListener { sn, err in
      if let err = err {
        print("error happened \(err)")
      }else {
        
        for doc in sn!.documents {
          let data = doc.data()
          
          self.user = User(name: data["name"] as? String ?? "No name available",
                           email: data["email"] as? String ?? "No email available",
                           age: data["age"] as? String ?? "No age available",
                           degree: data["degree"] as? String ?? "No degree available",
                           experience: data["exp"] as? String ?? "No experience available"
          )
        }
        
        DispatchQueue.main.async {
          if let user = self.user {
            self.nameLabel.text = user.name
            self.ageLabel.text = user.age
            self.experienceLabel.text = user.experience
            self.emailLabel.text = user.email
            self.degreeLabel.text = user.degree
          }
          else {
            print("this is the id \(user.uid)")
          }
          
        }
      }
      
    }
    
  }
  
  
  private func setupViews() {
    
    view.addSubview(nameHeader)
    view.addSubview(nameLabel)
    view.addSubview(emailHeader)
    view.addSubview(emailLabel)
    view.addSubview(ageHeader)
    view.addSubview(ageLabel)
    view.addSubview(degreeHeader)
    view.addSubview(degreeLabel)
    view.addSubview(experienceHeader)
    view.addSubview(experienceLabel)
    
    
    NSLayoutConstraint.activate([
      
      nameHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      nameHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: nameHeader.trailingAnchor, constant: 10),
      
      
      
      emailHeader.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      emailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      emailLabel.leadingAnchor.constraint(equalTo: emailHeader.trailingAnchor, constant: 10),
      
      
      
      degreeHeader.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
      degreeHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      degreeLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
      degreeLabel.leadingAnchor.constraint(equalTo: degreeHeader.trailingAnchor, constant: 10),
      
      
      
      experienceHeader.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 10),
      experienceHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      experienceLabel.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 10),
      experienceLabel.leadingAnchor.constraint(equalTo: experienceHeader.trailingAnchor, constant: 10),
      
      
      
      ageHeader.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 10),
      ageHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      ageLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 10),
      ageLabel.leadingAnchor.constraint(equalTo: ageHeader.trailingAnchor, constant: 10),
      
    ])
  }
}
