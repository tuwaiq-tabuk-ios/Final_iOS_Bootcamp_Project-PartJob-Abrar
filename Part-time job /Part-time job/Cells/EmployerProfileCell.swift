//
//  EmployerProfileCell.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 10/06/1443 AH.
//

import UIKit

class EmployerProfileCell: UITableViewCell {
  
  //  MARK: - Properties
  static let id = "EmployerProfileCell"
  
  
  //  MARK: - @IBOutlet
  let name: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText!
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    
    return lbl
  }()
  
  
  let email: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText!
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  
  let age: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText!
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  
  let degree: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText!
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  
  let experience: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText!
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  //  MARK: - Table Cell
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  
  //enable objects
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func updateCell(user: User) {
    name.text = user.name
    email.text = user.email
    age.text = user.age
    degree.text = user.degree
    experience.text = user.experience
  }
  
  
  private func setupViews() {
    addSubview(name)
    addSubview(email)
    addSubview(age)
    addSubview(degree)
    addSubview(experience)
    
    // elements constraints
    NSLayoutConstraint.activate([
      
      name.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
      
      email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
      email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
      age.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
      age.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      age.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
      degree.topAnchor.constraint(equalTo: age.bottomAnchor, constant: 10),
      degree.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      degree.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
      
      experience.topAnchor.constraint(equalTo: degree.bottomAnchor, constant: 10),
      experience.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      experience.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
    ])
  }
  
  
}
