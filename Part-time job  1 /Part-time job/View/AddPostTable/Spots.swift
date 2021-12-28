//
//  Spots.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 23/05/1443 AH.
//

import Foundation
import Firebase

class Spots {
  var spotArray: [Spot] = []
  var db: Firestore!
  
  init() {
    db = Firestore.firestore()
    
  }
  func loadData(completed: @escaping () -> ()) {
    db.collection("spots").addSnapshotListener { (querySnapshot, error) in
      guard error == nil else {
        print(" ☹️ Error: adding the snap shot listener  \(error!.localizedDescription)")
        return completed()
        
      }
      
      self.spotArray = [] // clean out existing spotArray aine new data will load
      
      // ther are querySnapshot!.documents.count documents in the snapshot
      for document in querySnapshot!.documents {
//        let spot = Spot()
        
      }
      
    }
  }
}
