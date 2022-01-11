//
//  OnboardingCollectionViewCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 17/05/1443 AH.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
  // MARK: - IBOutlets
  @IBOutlet weak var slideImageView: UIImageView!
  @IBOutlet weak var slideTitleLabel: UILabel!
  @IBOutlet weak var slideDescrbtionLabel: UILabel!
  
  
  func setup( _ slide: OnboardingSlide) {
    slideImageView.image = slide.image
    slideTitleLabel.text = slide.title
    slideDescrbtionLabel.text = slide.description
  }
  
}
