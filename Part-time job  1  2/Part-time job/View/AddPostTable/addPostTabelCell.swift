//
//  addPostTabelCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 24/05/1443 AH.
//

import UIKit

class addPostTabelCell: UITableViewCell {

//MARK: - @IBOutlet
  
  @IBOutlet weak var kindOfJobLabel: UILabel!
  @IBOutlet weak var timeOfJobLabel: UILabel!
  @IBOutlet weak var offerOfJobLabel: UILabel!
  @IBOutlet weak var imageOfJobe: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
