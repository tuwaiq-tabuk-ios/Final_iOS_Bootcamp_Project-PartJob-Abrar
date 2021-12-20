//
//  ViewController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 06/05/1443 AH.
//
import UIKit


class HomeViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var welcomLable: UILabel!
  @IBOutlet weak var youHaveAcountLable: UILabel!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    SetUpHomeViewController()
    
  }
//  override func viewWillDisappear(_ animated: Bool) {
//    let viewLogo = LogoController()
//    present(viewLogo, animated: false)
//
//  }
  
//  override func viewDidLayoutSubviews() {
//    let viewLogo = LogoController()
//    present(viewLogo, animated: false)
//
//  }
//  override func viewWillLayoutSubviews() {
//
//
//  }
//
 
  
} //end class

