//
//  MainCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit

class MainCell: UICollectionViewCell {
  //  MARK: - Properties
  static let id = "HomeCell"
  
  
  
  //  MARK: - @IBOutlet
  private let titleForJob: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .bold))
    lbl.backgroundColor = .clear
    lbl.numberOfLines = 0
    lbl.textAlignment = .left
    lbl.textColor = .white
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  
  private let companyForJob: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 11, weight: .bold))
    lbl.backgroundColor = .clear
    lbl.numberOfLines = 0
    lbl.textAlignment = .left
    lbl.textColor = .white.withAlphaComponent(0.56)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  
  private let descriptionForJob: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .regular))
    lbl.backgroundColor = .clear
    lbl.numberOfLines = 0
    lbl.textAlignment = .left
    lbl.textColor = .white
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  
  let imageForJob: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  //MARK: -
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCell()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func configureCell() {
    backgroundColor = .gray
    layer.cornerRadius = 5
    clipsToBounds = true
    layer.cornerCurve = .continuous
  }
  
  
  private func setupUI() {
    backgroundColor = .gray
    addSubview(imageForJob)
    addSubview(companyForJob)
    addSubview(titleForJob)
    addSubview(descriptionForJob)
    
    // elements constraints
    NSLayoutConstraint.activate([
      
      imageForJob.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      imageForJob.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      imageForJob.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      imageForJob.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      
      companyForJob.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      companyForJob.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      companyForJob.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      
      titleForJob.topAnchor.constraint(equalTo: companyForJob.bottomAnchor, constant: 8),
      titleForJob.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      titleForJob.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      
      
      descriptionForJob.topAnchor.constraint(equalTo: titleForJob.bottomAnchor, constant: 15),
      descriptionForJob.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      descriptionForJob.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      
    ])
  }
  
  
  func setCell(job: Job){
    titleForJob.text = job.jobTitle
    descriptionForJob.text = job.jobDescription
    
  }
  
}
