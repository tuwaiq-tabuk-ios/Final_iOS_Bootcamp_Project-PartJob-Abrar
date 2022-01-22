//
//  JobDetailVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit
import Firebase

class JobDetailVC: UIViewController {
  //  MARK: - Properties
  let db = Firestore.firestore()
  var job: Job!
  let scrollView  = UIScrollView()
  let contentView = UIView()
  
  
  //  MARK: - @IBOutlet
  let imageTitle: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Company Image".Localized
    return lbl
  }()
  
  let imageView: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let nameOfCompanyHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Company Name".Localized
    return lbl
  }()
  
  private let nameOfCompanyLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  private let jobTitleHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Job Title".Localized
    return lbl
  }()
  
  private let jobTitleLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
 
  private let cityHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "City".Localized
    return lbl
  }()
  
  private let cityLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  private let durationHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Duration".Localized
    return lbl
  }()
  
  private let durationLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
 
  private let salaryHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Salary".Localized
    return lbl
  }()
  
  private let salaryLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
 
  private let locationHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Location".Localized
    return lbl
  }()
  
  private let locationLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  
  private let descriptionHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Description For Job".Localized
    return lbl
  }()
  
  
  private let descriptionLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  let applyButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setupButton(with: "Apply Now!".Localized)
    btn.addTarget(self, action: #selector(applyForAJobTapped), for: .touchUpInside)
    btn.isHidden = true
    return btn
  }()
  
  //  MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .jobBackgroundColor
    setupScrollView()
    setupView()
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+105)
    
    isUserEmployer { [weak self] isEmployer in
      if isEmployer == "yes" {
        DispatchQueue.main.async {
          self?.applyButton.isHidden = true
        }
      }else if isEmployer == "no"{
        DispatchQueue.main.async {
          self?.applyButton.isHidden = false
        }
      }
    }
  }
  
  
  private func isUserEmployer(completion: @escaping (_ isEmployer: String) -> ()){
    guard let user = Auth.auth().currentUser else {return}
    db.collection("Users").whereField("userID", isEqualTo: user.uid)
      .getDocuments { (querySnapshot, error) in
        
        if let e = error {
          print("There was an issue retrieving data from Firestore. \(e)")
        } else {
          
          if querySnapshot!.documents.isEmpty {
            completion("no")
          }else{
            for document in querySnapshot!.documents{
              let data = document.data()
              completion(data["isEmployer"] as? String ?? "no")
            }
          }
        }
      }
  }
  
  
  private func setupScrollView(){
    scrollView.isScrollEnabled = true
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    
    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    
  }
  
  private func setupView() {
    
    nameOfCompanyLabel.text = job.companyName
    jobTitleLabel.text = job.jobTitle
    cityLabel.text = job.city
    durationLabel.text = job.duration
    salaryLabel.text = job.amountOfMoney
    locationLabel.text = job.location
    descriptionLabel.text = job.jobDescription
    scrollView.addSubview(imageTitle)
    scrollView.addSubview(imageView)
    scrollView.addSubview(nameOfCompanyHeaderLabel)
    scrollView.addSubview(nameOfCompanyLabel)
    scrollView.addSubview(jobTitleHeaderLabel)
    scrollView.addSubview(jobTitleLabel)
    scrollView.addSubview(cityHeaderLabel)
    scrollView.addSubview(cityLabel)
    scrollView.addSubview(durationHeaderLabel)
    scrollView.addSubview(durationLabel)
    scrollView.addSubview(salaryHeaderLabel)
    scrollView.addSubview(salaryLabel)
    scrollView.addSubview(locationHeaderLabel)
    scrollView.addSubview(locationLabel)
    scrollView.addSubview(descriptionHeaderLabel)
    scrollView.addSubview(descriptionLabel)
    view.addSubview(applyButton)
    
    
    
    NSLayoutConstraint.activate([
      
      imageTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      imageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      imageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      imageView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: 6),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      imageView.heightAnchor.constraint(equalToConstant: 138),
      
      nameOfCompanyHeaderLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
      nameOfCompanyHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      nameOfCompanyHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      nameOfCompanyLabel.topAnchor.constraint(equalTo: nameOfCompanyHeaderLabel.bottomAnchor, constant: 2),
      nameOfCompanyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      nameOfCompanyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      nameOfCompanyLabel.heightAnchor.constraint(equalToConstant: 15),
      
      
      jobTitleHeaderLabel.topAnchor.constraint(equalTo: nameOfCompanyLabel.bottomAnchor, constant: 15),
      jobTitleHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      jobTitleHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      jobTitleLabel.topAnchor.constraint(equalTo: jobTitleHeaderLabel.bottomAnchor, constant: 2),
      jobTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      jobTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      jobTitleLabel.heightAnchor.constraint(equalToConstant: 15),
      
      
      cityHeaderLabel.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 15),
      cityHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      cityHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      cityLabel.topAnchor.constraint(equalTo: cityHeaderLabel.bottomAnchor, constant: 2),
      cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      cityLabel.heightAnchor.constraint(equalToConstant: 15),
      
      durationHeaderLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 15),
      durationHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      durationHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      durationLabel.topAnchor.constraint(equalTo: durationHeaderLabel.bottomAnchor, constant: 2),
      durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      durationLabel.heightAnchor.constraint(equalToConstant: 15),
      
      
      salaryHeaderLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 15),
      salaryHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      salaryHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      salaryLabel.topAnchor.constraint(equalTo: salaryHeaderLabel.bottomAnchor, constant: 2),
      salaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      salaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      salaryLabel.heightAnchor.constraint(equalToConstant: 15),
      
      
      descriptionHeaderLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 15),
      descriptionHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      descriptionHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 2),
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      
      locationHeaderLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
      locationHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      locationHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      locationLabel.topAnchor.constraint(equalTo: locationHeaderLabel.bottomAnchor, constant: 2),
      locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      locationLabel.heightAnchor.constraint(equalToConstant: 15),
      
      
      
      applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      applyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
      applyButton.widthAnchor.constraint(equalToConstant: 90),
      applyButton.heightAnchor.constraint(equalToConstant: 30),
    ])
  }
  
  
  //MARK: - Data
  
  @objc private func applyForAJobTapped() {
    
    getUserData { name, age, exp, email, degree in
      self.db.collection("PeopleToInterview").document().setData([
        
        "name": name,
        "email": email,
        "age": age,
        "experience": exp,
        "degree": degree,
        "employerID": self.job.userID,
        
      ], merge: true) { error in
        if let err = error {
          print("Error writing document: \(err)")
        } else {
          print("Document successfully written!")
          DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "You applied for this job.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
              self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            
          }
        }
      }
    }
    
    
  }
  
  
  private func getUserData(completion: @escaping (_ name: String, _ age: String, _ exp: String, _ email: String,_ degree: String) -> Void) {
    guard let user = Auth.auth().currentUser else {return}
    var currentUser: User?
    db.collection("Users").whereField("userID", isEqualTo: user.uid)
      .getDocuments  { sn, err in
        if let err = err {
          print("error happened \(err)")
        }else {
          
          for doc in sn!.documents {
            let data = doc.data()
            
            currentUser = User(name: data["name"] as? String ?? "No name available",
                               email: data["email"] as? String ?? "No email available",
                               age: data["age"] as? String ?? "No age available",
                               degree: data["degree"] as? String ?? "No degree available",
                               experience: data["exp"] as? String ?? "No experience available"
                               
            )
            
            print(currentUser?.name ?? "nil")
            
          }
          if let currentUser = currentUser {
            completion(currentUser.name, currentUser.age, currentUser.experience, currentUser.email,  currentUser.degree)
          }else{
            print("errrrrorrrorroro: \(String(describing: currentUser))")
          }
          
        }
      }
  }
}
