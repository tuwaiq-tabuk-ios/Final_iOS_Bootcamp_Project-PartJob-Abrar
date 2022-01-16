//
//  UploadigJobDetailsVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseAuth
import PhotosUI

class UploadigJobDetailsVC: UIViewController,PHPickerViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate{
  
  
  //MARK: - Properties
  var pictures = [UIImage]()
  var currentIndex = 0
  
  var jobTypeSelector = UIPickerView()
  var cityNameSelector = UIPickerView()
  
  var typeOfJobArray = ["Programmer","Worker","Electrical"]
  var cityNameArr = ["Abha","Tabuk","Jeddah","Seoul"]
  
  
  //MARK: - @IBOutlets
  @IBOutlet weak var photosCollection: UICollectionView!
  @IBOutlet weak var kindOfJobTextField: UITextField!
  @IBOutlet weak var selectCityNameTF: UITextField!
  
  @IBOutlet weak var timeTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  
  
  //MARK: - View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // photosCollection
    photosCollection.delegate = self
    photosCollection.dataSource = self
    
    //jobTypeSelector
    jobTypeSelector.delegate = self
    jobTypeSelector.dataSource = self
    kindOfJobTextField.inputView = jobTypeSelector
    kindOfJobTextField.placeholder = "Select Job Type"
    
    //genderTypeSelector
    cityNameSelector.delegate = self
    cityNameSelector.dataSource = self
    selectCityNameTF.inputView = cityNameSelector
    selectCityNameTF.placeholder = "Select City Name"
    jobTypeSelector.tag = 1
    cityNameSelector.tag = 2
    
  }
  
  
  //MARK: - @IBActions
  
  @IBAction func uploadDataPressed(_ sender: UIButton) {
    
    let db = Firestore.firestore()
    let currentUserAuth = Auth.auth().currentUser
    let storage = Storage.storage()
    var documentID = ""
    
    if documentID == "" {
      documentID = UUID().uuidString
    }
    
    var imageID = UUID().uuidString
    let imagefFolderID = UUID().uuidString
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
    
    let typeJobe = self.kindOfJobTextField.text?.lowercased()

    _ = self.selectCityNameTF.text?.lowercased() //new obj
    
    
    var imagesData = [Data]()
    for picture in pictures {
      let data = picture.jpegData(compressionQuality: 0.5)
      imagesData.append(data!)
    }
    
    var imageURL = [String]()
    for image in imagesData {
      imageID = UUID().uuidString
      print(" - imageID: \(imageID))")
      let storageRf = storage.reference()
        .child(currentUserAuth!.uid)
        .child(imagefFolderID)
        .child(imageID)
      
      storageRf.putData(image, metadata: uploadMetadata) { metadata, error in
        guard error == nil else {
          return
        }
        
        storageRf.downloadURL { url, error in
          if error != nil {
          } else {
            imageURL.append(url!.absoluteString)
            
            //            database
         let database =   db.collection("TheJobOffer").document(typeJobe!).setData(["\(imagefFolderID)" : [
              "jobKind":self.kindOfJobTextField.text!,
              "time":self.timeTextField.text!,
              "amount":self.amountTextField.text!,
              "location":self.locationTextField.text!,
              "description":self.descriptionTextField.text!,
              "gender":self.selectCityNameTF.text!,//new obj
              "images":imageURL,
            ]],merge: true, completion: { error in
              guard error == nil else {
                return
              }
              print("-- Data Upload")
            })
          }
        }
      }
    }
  }
  
  
  
  @IBAction func logOutPressed(_ sender: Any) {

    do {
        try Auth.auth().signOut()
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HVC") as? UIViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }

    } catch{
        print("ERROR in signout",error.localizedDescription)
    }

    
  }
  
  
  @IBAction func uploadPhotos(_ sender: UIButton) {
    getPhotos()
  }
  
  
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    dismiss(animated: true, completion: nil)
    for resulr in results{
      print("\(results.count)")
      resulr.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {
        (imagePic,error) in
        if let imagePice = imagePic as? UIImage {
          DispatchQueue.main.async{
            self.pictures.append(imagePice)
            self.photosCollection.reloadData()
          }
        } else {
          
        }
      }
      )
    }
  }
  
  func getPhotos(){
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 3
    
    let phPickre = PHPickerViewController(configuration: config)
    phPickre.delegate = self
    present(phPickre, animated: true, completion: nil)
    
  }
  
  
  //MARK: - Collection View  Data Source
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pictures.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = photosCollection.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! UploadingDataCollectionImage
    cell.uploadingImages.image = pictures[indexPath.row]
    
    return cell
  }
  
  
  
  //MARK: - Picker View Data Source
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch pickerView.tag {
    case 1:
      return typeOfJobArray.count
    case 2:
      return cityNameArr.count
      
    default:
      return 1
    }
//    return typeOfJobArray.count
  }
  

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

    switch pickerView.tag {
    case 1:
      
      return typeOfJobArray[row]
    case 2:
      return cityNameArr[row]
      
    default:
      return " Data not found"
    }
    
    

  }
  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch pickerView.tag {
    case 1:
      kindOfJobTextField.text = typeOfJobArray[row]
      kindOfJobTextField.resignFirstResponder()
    case 2:
      selectCityNameTF.text = cityNameArr[row]
      selectCityNameTF.resignFirstResponder()
      
    default:
      return
    }
 }
  
 
  
} // end class
