
import UIKit
import Firebase
import PhotosUI
import FirebaseAuth
import FirebaseStorage

class JobOfferEditingVC: UIViewController  {
  
  //MARK: - @IBOutlet
  @IBOutlet weak var jobNameTextFiled: UITextField!
  @IBOutlet weak var jobTimeTextFiled: UITextField!
  @IBOutlet weak var photoCollectionView: UICollectionView!
  @IBOutlet weak var jobOffferTextFiled: UITextField!
  
  
  var arrayPhoto = [UIImage]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  //MARK: - @IBAction
  @IBAction func saveData(_ sender: UIButton) {
    
    let db = Firestore.firestore()
    let auth = Auth.auth().currentUser
    let storage = Storage.storage()
    
    var documentID = ""
    if documentID == "" {
      documentID = UUID().uuidString
    }
    
    var imageID = UUID().uuidString
    let imagefFolderID = UUID().uuidString
    let uploadMetadata = StorageMetadata()
    uploadMetadata.contentType = "image/jpeg"
//    let type = self.selectType.text?.lowercased()
    let database = db.collection("Offer").document(type!)
    let id = database.documentID
    database.setData(["\(imagefFolderID)" : [
      "jobName":self.jobNameTextFiled.text!,
      "jobTime":self.jobTimeTextFiled.text!,
      "jobOfffer":self.jobOffferTextFiled.text!,
//      "selectType":self.selectType.text!,
//      "productDescription":self.productDescription.text!,
//      "images":[" "],
//      "logo":"https://google.com",
    ]]
                     ,merge: true) {
      error in
      guard error == nil else {
        return
      }
      db.collection("stores").document(auth!.uid).collection("store").document(imagefFolderID).setData([
        "id":imagefFolderID,
        "taype":type!,
      ]) {
        error in
        guard error == nil else {
          return
        }
      }
    }
    var imageData = [Data]()
    for image in arrayPhoto {
      let data = image.jpegData(compressionQuality: 0.5)
      imageData.append(data!)
    }
    var imageURL = [String]()
    for image in imageData {
      imageID = UUID().uuidString
      let storageRf = storage.reference().child(auth!.uid).child(imagefFolderID).child(imageID)
      storageRf.putData(image, metadata: uploadMetadata) { metadata, error in
        guard error == nil else {
          return
        }
        storageRf.downloadURL { url, error in
          if error != nil {
          } else {
            imageURL.append(url!.absoluteString)
            
            //            database
            db.collection("Offer").document(type!).setData(["\(imagefFolderID)" : [
              "jobName":self.jobNameTextFiled.text!,
              "jobTime":self.jobTimeTextFiled.text!,
              "jobOfffer":self.jobOffferTextFiled.text!,
              "selectType":self.selectType.text!,
              "productDescription":self.productDescription.text!,
              "images":imageURL,
              "logo":"https://google.com",
            ]],merge: true, completion: {
              error in
              guard error == nil else {
                print("~~ error: \(error?.localizedDescription)")
                return
              }
              print("~~ Done")
            })
          }
        }
      }
    }
  }
  
  
  
}

//MARK: - Photo Collection View Data Source
extension JobOfferEditingVC : UICollectionViewDelegate , UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    <#code#>
  }
  
  
}
