//
//  CustomToolbarVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 15/05/1443 AH.
//

import UIKit


class CustomToolbarVC: UIViewController {
  
  @IBOutlet weak var kindOfJobeTextFiled: UITextField!
  @IBOutlet weak var timeJobeTextFiled: UITextField!

  @IBOutlet weak var jobOffferTextFiled: UITextField!
  
  var spot: Spot!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if spot == nil {
      spot = Spot()
      }
    
    updateUserInterface()
     
  }
  
  func updateUserInterface() {
    kindOfJobeTextFiled.text = spot.name
    timeJobeTextFiled.text =  spot.address
  }
  
  func updateFromeInterface() {
    spot.name = kindOfJobeTextFiled.text!
    spot.address = timeJobeTextFiled.text!
    
  }
  
  func leaveViewController() {
    let isPresentingInMode = presentingViewController is UINavigationController
    if isPresentingInMode {
      dismiss(animated: true, completion: nil)
    } else {
      navigationController?.popViewController(animated: true)
    }
    
  }
  
  
  
  
  
  
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    leaveViewController()
  }
  
  

  
  
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    updateFromeInterface()
    spot.saveData { (success) in
      if success {
        self.leaveViewController()
      } else {
        // Error during save occurred
        self.oneButtonAlert(title: "Save Failed", message: "For some reson , the data would not save to the cloud.  ")
      }
      
    }
    
  }
  
  
  
  
  
}
