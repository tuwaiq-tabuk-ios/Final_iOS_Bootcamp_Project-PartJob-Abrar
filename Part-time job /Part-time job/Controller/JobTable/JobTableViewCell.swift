//
//  JobTableViewCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 11/05/1443 AH.
//

import UIKit

class JobTableViewCell: UITableViewCell {
  
  // MARK: - IBOutlets
  

  @IBOutlet weak var JobNameLabel: UILabel!
  @IBOutlet weak var JobTimeLabel: UILabel!
  @IBOutlet weak var JobOfferLabel: UILabel!
  @IBOutlet weak var JobImage: UIImageView!
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
