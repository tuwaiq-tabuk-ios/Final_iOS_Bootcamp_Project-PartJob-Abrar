//
//  AddJobVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage

class AddJobVC: UIViewController {
  
  //  MARK: - Properties
  private let db = Firestore.firestore()
  private let scrollView  = UIScrollView()
  private let contentView = UIView()
  private let imagePicker = UIImagePickerController()
  private let storage = Storage.storage()
  private var userPickedImage: UIImage?
  
  //  MARK: - @IBOutlet
  //MARK: -
  let imageTitle: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Company Image"
    return lbl
  }()
  
  let imageView: UIImageView = {
    let pI = UIImageView()
    pI.contentMode = .scaleAspectFit
    pI.clipsToBounds = true
    pI.layer.cornerRadius = 13
    pI.layer.borderColor = UIColor.jobActionColors!.cgColor
    pI.layer.borderWidth = 1
    pI.image = UIImage(systemName: "photo.on.rectangle")?.withTintColor(.gray).withRenderingMode(.alwaysOriginal)
    pI.translatesAutoresizingMaskIntoConstraints = false
    return pI
  }()
  
  //MARK: -
  private let nameOfCompanyHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Company Name"
    return lbl
  }()
  
  
  private let nameOfCompanyTF: UITextField = {
    let textField = UITextField()
    textField.setupTextField(with:  NSAttributedString(string: "Ex: RiyadhBank",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
    return textField
  }()
  //MARK: -
  private let jobTitleHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Job Title"
    return lbl
  }()
  
  
  private let jobTitleTF: UITextField = {
    let textField = UITextField()
    textField.setupTextField(with:NSAttributedString(string: "Ex: iOS Engineer",
                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
    return textField
  }()
  //MARK: -
  private let cityHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "City"
    return lbl
  }()
  
  
  private let cityTF: UITextField = {
    let textField = UITextField()
    textField.setupTextField(with:  NSAttributedString(string: "Ex: Riyadh",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
    return textField
  }()
  //MARK: -
  private let durationHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Duration"
    return lbl
  }()
  
  
  private let durationTF: UITextField = {
    let textField = UITextField()
    textField.setupTextField(with:  NSAttributedString(string: "Ex: 1-Month or 1-Year",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
    return textField
  }()
  //MARK: -
  private let salaryHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Salary"
    return lbl
  }()
  
  
  private let salaryTF: UITextField = {
    let textField = UITextField()
    textField.setupTextField(with:  NSAttributedString(string: "Ex: 10,000 SAR",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
    return textField
  }()
  //MARK: -
  private let locationHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Location"
    return lbl
  }()
  
  
  private let locationTF: UITextField = {
    let textField = UITextField()
    textField.setupTextField(with:  NSAttributedString(string: "Ex: Street name, Road name",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)]))
    return textField
  }()
  //MARK: -
  private let descriptionHeaderLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors!.withAlphaComponent(0.57)
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Description For Job"
    return lbl
  }()
  
  
  private let descriptionTV: UITextView = {
    let tf = UITextView()
    tf.setupTextView()
    return tf
  }()
  
  //MARK: -
  private let addButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setupButton(with: "Create a new job")
    return btn
  }()
  
  
  //  MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Create a job"
    view.backgroundColor = .jobBackgroundColor
    self.dismissKeyboard()
    setupScrollView()
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+485)
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
  
  
  private func setupImagePicker() {
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true)
  }
  
  
  @objc func imageTapped() {
    setupImagePicker()
  }
  
  
  private func setupView() {
    
    imageView.isUserInteractionEnabled = true
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
    imageView.addGestureRecognizer(tapRecognizer)
    
    scrollView.addSubview(imageTitle)
    scrollView.addSubview(imageView)
    scrollView.addSubview(nameOfCompanyHeaderLabel)
    scrollView.addSubview(nameOfCompanyTF)
    scrollView.addSubview(jobTitleHeaderLabel)
    scrollView.addSubview(jobTitleTF)
    scrollView.addSubview(cityHeaderLabel)
    scrollView.addSubview(cityTF)
    scrollView.addSubview(durationHeaderLabel)
    scrollView.addSubview(durationTF)
    scrollView.addSubview(salaryHeaderLabel)
    scrollView.addSubview(salaryTF)
    scrollView.addSubview(locationHeaderLabel)
    scrollView.addSubview(locationTF)
    scrollView.addSubview(descriptionHeaderLabel)
    scrollView.addSubview(descriptionTV)
    scrollView.addSubview(addButton)
    
    descriptionTV.delegate = self
    
    nameOfCompanyTF.delegate = self
    jobTitleTF.delegate = self
    cityTF.delegate = self
    durationTF.delegate = self
    salaryTF.delegate = self
    locationTF.delegate = self
    descriptionTV.delegate = self
    
    addButton.addTarget(self, action: #selector(createNewJob), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      
      imageTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      imageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      imageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      imageView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor, constant: 10),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      imageView.heightAnchor.constraint(equalToConstant: 138),
      
      nameOfCompanyHeaderLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
      nameOfCompanyHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      nameOfCompanyHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      nameOfCompanyTF.topAnchor.constraint(equalTo: nameOfCompanyHeaderLabel.bottomAnchor, constant: 10),
      nameOfCompanyTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      nameOfCompanyTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      nameOfCompanyTF.heightAnchor.constraint(equalToConstant: 45),
      
      
      jobTitleHeaderLabel.topAnchor.constraint(equalTo: nameOfCompanyTF.bottomAnchor, constant: 30),
      jobTitleHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      jobTitleHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      jobTitleTF.topAnchor.constraint(equalTo: jobTitleHeaderLabel.bottomAnchor, constant: 10),
      jobTitleTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      jobTitleTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      jobTitleTF.heightAnchor.constraint(equalToConstant: 45),
      
      
      cityHeaderLabel.topAnchor.constraint(equalTo: jobTitleTF.bottomAnchor, constant: 30),
      cityHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      cityHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      cityTF.topAnchor.constraint(equalTo: cityHeaderLabel.bottomAnchor, constant: 10),
      cityTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      cityTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      cityTF.heightAnchor.constraint(equalToConstant: 45),
      
      durationHeaderLabel.topAnchor.constraint(equalTo: cityTF.bottomAnchor, constant: 30),
      durationHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      durationHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      durationTF.topAnchor.constraint(equalTo: durationHeaderLabel.bottomAnchor, constant: 10),
      durationTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      durationTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      durationTF.heightAnchor.constraint(equalToConstant: 45),
      
      
      salaryHeaderLabel.topAnchor.constraint(equalTo: durationTF.bottomAnchor, constant: 30),
      salaryHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      salaryHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      salaryTF.topAnchor.constraint(equalTo: salaryHeaderLabel.bottomAnchor, constant: 10),
      salaryTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      salaryTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      salaryTF.heightAnchor.constraint(equalToConstant: 45),
      
      
      descriptionHeaderLabel.topAnchor.constraint(equalTo: salaryTF.bottomAnchor, constant: 30),
      descriptionHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      descriptionHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      descriptionTV.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 10),
      descriptionTV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      descriptionTV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      descriptionTV.heightAnchor.constraint(equalToConstant: 145),
      
      locationHeaderLabel.topAnchor.constraint(equalTo: descriptionTV.bottomAnchor, constant: 30),
      locationHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      locationHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      locationTF.topAnchor.constraint(equalTo: locationHeaderLabel.bottomAnchor, constant: 10),
      locationTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      locationTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      locationTF.heightAnchor.constraint(equalToConstant: 45),
      
      addButton.topAnchor.constraint(equalTo: locationTF.bottomAnchor, constant: 20),
      addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      addButton.heightAnchor.constraint(equalToConstant: 45),
      
    ])
  }
  
  @objc private func createNewJob() {
    saveDataToFireStorage()
    
  }
}

extension AddJobVC: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
    descriptionHeaderLabel.text = "Description For Job " + "180/" + "\(updatedText.count - 1)"
    return updatedText.count <= 180
  }
}

//  MARK: - Picker View Data Source
extension AddJobVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    
    guard let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
    imageView.image = userPickedImage
    self.userPickedImage = userPickedImage
    
    picker.dismiss(animated: true, completion: nil)
  }
}

//MARK: - FireStore and Fire Storage functions

extension AddJobVC {
  private func saveToFireStore(userID: String,
                               companyName: String,
                               job: String,
                               city: String,
                               duration: String,
                               salary: String,
                               location: String,
                               description: String,
                               imageURL: URL?) {
    
    let ref = db.collection("Jobs").document()
    ref.setData([
      "companyName": companyName,
      "jobTitle": job,
      "city": city,
      "duration": duration,
      "salary": salary,
      "location": location,
      "description": description.isEmpty ? "nil" : description,
      "imageURL": "\(imageURL!)",
      "docID": ref.documentID,
      "userID": userID,
    ], merge: true) { err in
      if let err = err {
        print("Error writing document: \(err)")
      } else {
        print("Document successfully written!")
        DispatchQueue.main.async {
          let alert = UIAlertController(title: "Success", message: "We created a new job.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.nameOfCompanyTF.text = ""
            self.jobTitleTF.text = ""
            self.cityTF.text = ""
            self.durationTF.text = ""
            self.salaryTF.text = ""
            self.locationTF.text = ""
            self.descriptionTV.text = ""
            self.navigationController?.popViewController(animated: true)
          }))
          self.present(alert, animated: true, completion: nil)
          
          
        }
      }
      
    }
  }
  
  private func saveDataToFireStorage() {
    guard let companyName = nameOfCompanyTF.text,
          let job = jobTitleTF.text,
          let city = cityTF.text,
          let duration = durationTF.text,
          let salary = salaryTF.text,
          let location = locationTF.text,
          let description = descriptionTV.text
    else {return}
    
    
    if companyName.isEmpty || job.isEmpty || city.isEmpty || duration.isEmpty || salary.isEmpty || location.isEmpty{
      
      let alert = UIAlertController(title: "Error", message: "please fill out all the required fields", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      self.present(alert, animated: true, completion: nil)
      
    }else{
      
      if let userimage = userPickedImage {
        guard let d: Data = userimage.jpegData(compressionQuality: 0.5) else { return }
        guard let currentUser = Auth.auth().currentUser else {return}
        
        let uuid = UUID()
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let ref = storage.reference().child("advertisement/\(currentUser.email!)/\(currentUser.uid)\(uuid).jpg")
        
        
        ref.putData(d, metadata: metadata) { (metadata, error) in
          if error == nil {
            ref.downloadURL(completion: { (url, error) in
              self.saveToFireStore(userID: currentUser.uid, companyName: companyName, job: job, city: city, duration: duration, salary: salary, location: location, description: description, imageURL: url)
            })
          }else{
            print("error \(String(describing: error))")
          }
        }
      }else{
        let alert = UIAlertController(title: "Error", message: "You need to add an image for the current job offer.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
      
      
    }
    
  }
}


extension AddJobVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    nameOfCompanyTF.resignFirstResponder()
    jobTitleTF.resignFirstResponder()
    cityTF.resignFirstResponder()
    durationTF.resignFirstResponder()
    salaryTF.resignFirstResponder()
    locationTF.resignFirstResponder()
    
    
    return true
  }
}
