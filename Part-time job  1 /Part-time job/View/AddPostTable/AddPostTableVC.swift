//
//  AddPostTableVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit

class AddPostTableVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
  
  var JobeTableArr =  [
   
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                 jobOffer:  "50$",
                  image: UIImage(named: "logo")
                  
                 ) ,
    
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                  jobOffer: "50$",
                  image: UIImage(named: "logo")
                  
                 ) ,
    
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                  jobOffer: "50$",
                  image: UIImage(named: "logo")
                  
                 ) ,
    
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                  jobOffer: "50$",
                  image: UIImage(named: "logo")
                  
                 ) ,
    
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                  jobOffer: "50$",
                  image: UIImage(named: "logo")
                  
                 )
    
   ]
  
  
 
  
  @IBOutlet weak var addPostTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
  
  // MARK: - Table view data source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return JobeTableArr.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobTableViewCell
    cell.JobNameLabel.text = JobeTableArr[indexPath.row].jobName
    cell.JobTimeLabel.text = JobeTableArr[indexPath.row].jobTime
    cell.JobOfferLabel.text = JobeTableArr[indexPath.row].jobOffer
    cell.JobImage.image = JobeTableArr[indexPath.row].image
    
    return cell
  }
  
}
