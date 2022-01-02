//
//  AddPostTableVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit

class AddPostTableVC: UIViewController {
  
  //  MARK: - @IBOutlet
  @IBOutlet weak var addPostTableView: UITableView!
  
//  var spots: Spots!
  
  var dbb = ["h"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    spots = Spots()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.addPostTableView.reloadData()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowDetail" {
      let destanation = segue.destination as! JobOfferEditingVC
      let selectedIndexPath = addPostTableView.indexPathForSelectedRow!
//      destanation.spot = spots.spotArray[selectedIndexPath.row]
      
    }
  }
}

// MARK: - Table view data source
extension AddPostTableVC: UITableViewDelegate , UITableViewDataSource {
  //Number Of Rows
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dbb.count
//
  }
  // Cell Data
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddPostTabelCell
    
//    cell.textLabel?.text = spots.spotArray[indexPath.row].name
//
    return cell
  }
  
  
  //  tableView.dequeueReusableCell(withIdentifier: "JobCell") as! JobTableViewCell
  //  cell.JobNameLabel.text = JobeTableArr[indexPath.row].jobName
  //  cell.JobTimeLabel.text = JobeTableArr[indexPath.row].jobTime
  //  cell.JobOfferLabel.text = JobeTableArr[indexPath.row].jobOffer
  //  cell.JobImage.image = JobeTableArr[indexPath.row].image
  //
  
  
}
