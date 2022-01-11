//
//  SettingCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 07/05/1443 AH.
//

import UIKit

class SettingCell: UITableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var settingImageView: UIImageView!
  @IBOutlet weak var settingTitleLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
