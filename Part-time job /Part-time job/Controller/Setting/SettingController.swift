//
//  SettingController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 07/05/1443 AH.
//

import UIKit

class SettingController: UIViewController , UITableViewDataSource {
  
  var settingArr = [
    
    SettingModel(title:  "Languege",
                 image: UIImage(named: "translet")!),
    
    SettingModel(title:  "Dark Mood",
                 image: UIImage(named: "moon")!),
    
  
    SettingModel(title:  "Notification",
                 image: UIImage(named: "Notification")!)
  
  ]
  
  
  @IBOutlet var settingTable: UITableView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    settingTable.dataSource = self
    
    
  }
  

// MARK: - Table view data source


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return settingArr.count
  
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
  let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell" ) as! SettingCell
  cell.settingTitleLabel.text = settingArr[indexPath.row].title

  cell.settingImageView.image = settingArr[indexPath.row].image
  return cell
  
}
}
