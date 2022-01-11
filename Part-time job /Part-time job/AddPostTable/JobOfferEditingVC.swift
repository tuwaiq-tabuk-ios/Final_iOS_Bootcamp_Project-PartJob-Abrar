
import UIKit
import Firebase
import PhotosUI
import FirebaseAuth
import FirebaseStorage

class JobOfferEditingVC: UIViewController {
  
  
  
  //MARK: - @IBOutlet
  @IBOutlet weak var jobNameTextFiled: UITextField!
  @IBOutlet weak var jobTimeTextFiled: UITextField!

  @IBOutlet weak var photoCollection: UICollectionView!
  
  @IBOutlet weak var amountOfMoneyTextFiled: UITextField!
  
  @IBOutlet weak var jobAddressTextFiled: UITextField!
  




  var arrayPhotos = [UIImage]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photoCollection.delegate = self
    photoCollection.dataSource = self
    
  }
  
  //MARK: - @IBAction
  @IBAction func saveData(_ sender: UIButton) {
    
//    let db = Firestore.firestore()
//    let auth = Auth.auth().currentUser
//    let storage = Storage.storage()
//
//    var documentID = ""
//    if documentID == "" {
//      documentID = UUID().uuidString
//    }
//
//    var imageID = UUID().uuidString
//    let imagefFolderID = UUID().uuidString
//    let uploadMetadata = StorageMetadata()
//    uploadMetadata.contentType = "image/jpeg"
////    let type = self.selectType.text?.lowercased()
    ///
//    let database = db.collection("Offer").document(type!)
//    let id = database.documentID
//    database.setData(["\(imagefFolderID)" : [
//      "jobName":self.jobNameTextFiled.text!,
//      "jobTime":self.jobTimeTextFiled.text!,
//      "jobOfffer":self.jobOffferTextFiled.text!,
//      "selectType":self.selectType.text!,
//      "productDescription":self.productDescription.text!,
//      "images":[" "],
//      "logo":"https://google.com",
//    ]]
//                     ,merge: true) {
//      error in
//      guard error == nil else {
//        return
//      }
//      db.collection("stores").document(auth!.uid).collection("store").document(imagefFolderID).setData([
//        "id":imagefFolderID,
//        "taype":type!,
//      ]) {
//        error in
//        guard error == nil else {
//          return
//        }
//      }
//    }
//    var imageData = [Data]()
//    for image in arrayPhoto {
//      let data = image.jpegData(compressionQuality: 0.5)
//      imageData.append(data!)
//    }
//    var imageURL = [String]()
//    for image in imageData {
//      imageID = UUID().uuidString
//      let storageRf = storage.reference().child(auth!.uid).child(imagefFolderID).child(imageID)
//      storageRf.putData(image, metadata: uploadMetadata) { metadata, error in
//        guard error == nil else {
//          return
//        }
//        storageRf.downloadURL { url, error in
//          if error != nil {
//          } else {
//            imageURL.append(url!.absoluteString)
//
//            //            database
//            db.collection("Offer").document(type!).setData(["\(imagefFolderID)" : [
//              "jobName":self.jobNameTextFiled.text!,
//              "jobTime":self.jobTimeTextFiled.text!,
//              "jobOfffer":self.jobOffferTextFiled.text!,
//              "selectType":self.selectType.text!,
//              "productDescription":self.productDescription.text!,
//              "images":imageURL,
//              "logo":"https://google.com",
//            ]],merge: true, completion: {
//              error in
//              guard error == nil else {
//                print("~~ error: \(error?.localizedDescription)")
//                return
//              }
//              print("~~ Done")
//            })
//          }
//        }
//      }
//    }
//  }
//
  }
  
  
  @IBAction func cancelButton(_ sender: Any) {
    
    leaveScreen()
  }
  
  
  
  @IBAction func getPhotoBtn(_ sender: UIButton) {
    self.arrayPhotos.removeAll()
    getPhotos()
  }
  
  
  func leaveScreen(){
      let isPresentingInAddMode = presentingViewController is UINavigationController
      if isPresentingInAddMode {
        dismiss(animated: true, completion: nil)
      }
    else {
        navigationController?.popViewController(animated: true)
      }
      
    }
  
  
}

//MARK: - Photo Collection View Data Source
extension JobOfferEditingVC : UICollectionViewDelegate , UICollectionViewDataSource ,  PHPickerViewControllerDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayPhotos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
//
//    cell.imageCell.image = arrayPhotos[indexPath.row]
//    return cell
//  }
  
  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell

  if arrayPhotos.count > 0 {
    cell.imageCell.image = arrayPhotos[indexPath.row]
    

  }



  return cell

}
  
//  (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//  {
//  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//  cell.backgroundColor = [UIColor whiteColor];
//  return cell;
//  }
  
  
  
  func getPhotos(){
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 3
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    
    dismiss(animated: true, completion: nil)
    for result in results {
      result.itemProvider.loadObject(ofClass: UIImage.self , completionHandler: { (image , error) in
        if let image = image as? UIImage {
          DispatchQueue.main.async {
            self.arrayPhotos.append(image)
            self.photoCollection.reloadData()
          }
        }
        else {
          
        }
        
      })
    }
  }
  
  
  
}
