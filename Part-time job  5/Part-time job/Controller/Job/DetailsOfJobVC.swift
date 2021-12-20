//
//  DetailsOfJobVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 15/05/1443 AH.
//

import UIKit

class DetailsOfJobVC: UIViewController {
  
  var jobTableViewCell : JobTableModel!
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var jobImageView: UIImageView!
  @IBOutlet weak var jobTitleLabel: UILabel!
  @IBOutlet weak var jobDetailLabel: UILabel!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      jobImageView.image = jobTableViewCell.image
      jobDetailLabel.text = jobTableViewCell.details
      jobTitleLabel.text = jobTableViewCell.jobName
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
