//
//  Buttons.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit


extension UIButton {
  open func setupButton(with title: String) {
    backgroundColor = .jobActionColors
    setTitle(title, for: .normal)
    setTitleColor(.white, for: .normal)
    layer.cornerRadius = 10
    clipsToBounds = true
    translatesAutoresizingMaskIntoConstraints = false
  }
}
