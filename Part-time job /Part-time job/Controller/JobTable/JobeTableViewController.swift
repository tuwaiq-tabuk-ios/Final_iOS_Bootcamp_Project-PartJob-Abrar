//
//  JobeTableViewController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 11/05/1443 AH.
//

import UIKit

class JobeTableViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
  
  
  var JobeTableArr =  [
    
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                  jobOffer: "50$",
                  image: UIImage(named: "logo"),
                  jobDetails: "Work for 5 hours in coffee with 5 crow for a week"
                  
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
                  image: UIImage(named: "logo")!) ,
    
    JobTableModel(jobName: "Barsta",
                  jobTime: "5 Hours ",
                  jobOffer: "50$",
                  image: UIImage(named: "logo")!)
  ]
  
  
  
  @IBOutlet weak var JobTableView: UITableView!
  
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
  
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    
    let jobTable = JobeTableArr[indexPath.row]
    
    let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC")
    as? DetailsOfJobVC
    
    
    if let viewController = vc {
      viewController.jobTableViewCell = jobTable
      // present way
      //      present(viewController ,
      //            animated: true,
      //            completion: nil)
      //      navigationController way
      
      navigationController?.pushViewController(viewController, animated: true)
      
      
    }
  }
}
