//
//  Spot.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 23/05/1443 AH.
//

import Foundation
import Firebase

class Spot {
  var name: String
  var address: String
  var averageReating: Double
  var numberOfReviews: Int
  var postingUserID : String
  var decomuntID: String
  
  var dictionary: [String: Any] {
    return ["name": name,
            "address":address,
            "averageReating":averageReating,
            "numberOfReviews":numberOfReviews,
            "postingUserID":postingUserID,
            "decomuntID":decomuntID]
  }
  
  init(name:String,
       address: String,
       averageReating: Double,
       numberOfReviews: Int,
       postingUserID : String,
       decomuntID: String) {
    
    self.name = name
    self.address = address
    self.averageReating = averageReating
    self.numberOfReviews  = numberOfReviews
    self.postingUserID = postingUserID
    self.decomuntID = decomuntID
    
  }
  
  convenience init() {
    self.init(name: "",
              address:"",
              averageReating: 0.0 ,
              numberOfReviews: 0 ,
              postingUserID: "" ,
              decomuntID: "")
  }
  
  convenience init(dictionary: [String: Any]) {
    let name = dictionary["name"] as! String? ?? ""
    let address = dictionary["address"] as! String? ?? ""
    let averageReating = dictionary["averageReating"] as! Double? ?? 0.0
    let numberOfReviews = dictionary["numberOfReviews"] as! Int? ?? 0
    let postingUserID = dictionary["postingUserID"] as! String? ?? ""
    let decomuntID = dictionary["decomuntID"] as! String? ?? ""
    self.init(name: "",
              address:"",
              averageReating: 0.0 ,
              numberOfReviews: 0 ,
              postingUserID: "" ,
              decomuntID: "")
  }
  
  func saveData(completion: @escaping(Bool)-> ()) {
    let db = Firestore.firestore()
    
    //Grab the user ID
    guard let postUID = Auth.auth().currentUser?.uid else {
      print("☹️Error: Could not say data because we don't have a valid postingUserId.")
      return completion(false)
    }
    
    self.postingUserID = postUID
    
    //Creat the dictionary representing data we want to save
    let dataToSave: [String: Any] = self.dictionary
    
    // if we have saved a record, we'll have an ID , otherwise .addDocument will creat one.
    if self.decomuntID == "" { //create a new document via .addDocument
      var ref: DocumentReference? = nil // Firestore will creat a new ID for us
      ref = db.collection("spots").addDocument(data: dataToSave){ (error) in
        guard error == nil else {
          print("☹️ Error: adding document \(error!.localizedDescription)")
          return completion(false)
        }
        
        self.decomuntID = ref!.documentID
        print("💨 Added document: \(self.decomuntID)") // It worked!
        
        completion(true)
      }
    } else { // else save to the existing decomuntID w/ .setData
      let ref = db.collection("spot").document(self.decomuntID)
      ref.setData(dataToSave) { (error) in
        guard error == nil else {
          print(" ☹️ Error: adding document \(error!.localizedDescription)")
          return  completion(false)
        }
        print("💨 Update document: \(self.decomuntID)") // It worked!
        
        completion(true)
      }
    }
  }
  
}
