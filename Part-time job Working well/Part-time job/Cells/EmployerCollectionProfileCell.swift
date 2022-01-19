//
//  EmployerCollectionProfileCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 29/05/1443 AH.
//

import UIKit

class EmployerCollectionProfileCell: UICollectionViewCell {

  //  MARK: - Properties
  static let id = "EmployerCollectionProfileCell"
  
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
  private let deleteLabel: UILabel = {
    let lbl = UILabel()
    lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .bold))
    lbl.backgroundColor = .systemRed.withAlphaComponent(0.35)
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    lbl.textColor = .white
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "DELETE"
    lbl.layer.cornerRadius = 5
    lbl.clipsToBounds = true
    return lbl
  }()
  let imageForJob: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFill
    img.clipsToBounds = true
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCell()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func configureCell() {
    backgroundColor = .jobCellColor
    layer.cornerRadius = 5
    clipsToBounds = true
    layer.cornerCurve = .continuous
  }
  
  
  private func setupUI() {
    backgroundColor = .jobBackgroundColor
    addSubview(imageForJob)
    addSubview(companyForJob)
    addSubview(titleForJob)
    addSubview(descriptionForJob)
    addSubview(deleteLabel)
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
      
      
      deleteLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      deleteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      deleteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      deleteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
    ])
  }
  
  
  func setCell(job: Job){
    titleForJob.text = job.jobTitle
    descriptionForJob.text = job.jobDescription
    
  }
  
}
