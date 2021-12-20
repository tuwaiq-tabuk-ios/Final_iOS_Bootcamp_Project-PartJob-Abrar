//
//  Ext.Configure.swift
//  DO IT Welcom
//
//  Created by ABRAR ALQARNI on 06/05/1443 AH.
//

import UIKit

extension HomeViewController {
 
  func SetUpHomeViewController(){
    
    // Style the elements
    loginButton.setupButton(title: "Login",
                            sizeOfText: 20,
                            wightOfText:.bold ,
                            titleColor: .white,
                            cornerRad: 15)
    
    signInButton.setupButton(title: "Create Account",
                             sizeOfText: 19,
                             wightOfText: .medium,
                             titleColor: .black,
                             cornerRad: 15)
    
    welcomLable.setupLable(titleLabel: "Welcom in my App",
                           backgrounC: .clear,
                           sizeOfText: 30,
                           wightOfText: .medium,
                           alignText: .left)
    
    youHaveAcountLable.setupLable(titleLabel: "Do you have account?",
                                  backgrounC: .clear,
                                  sizeOfText: 17,
                                  wightOfText: .regular,
                                  alignText: .left)
    
  }
  
}


extension JoinController {
  func SetUpJoinController(){
    
    // Style the elements
    asCompany.setupButton(title: "Business Owner",
                          sizeOfText: 20,
                          wightOfText: .bold,
                          titleColor: .white,
                          cornerRad: 15)
    
    
    asEmployee.setupButton(title: "Job Seekers",
                           sizeOfText: 20, wightOfText: .bold,
                           titleColor: .white,
                           cornerRad: 0)
    
    askAboutJoin.setupLable(titleLabel: "Do You Want Join As?",
                            backgrounC: .clear,
                            sizeOfText: 17,
                            wightOfText: .regular,
                            alignText: .left)
    
  }
  
}


extension LoginViewController {
  
  func SetUpLoginViewController(){
    
    // Hide the error label
    errorLabel.alpha = 0
    
    // Style the elements
    
    emailTextField.setupTextField(emailTextField)
    passwordTextField.setupTextField(passwordTextField)
    
    loginButton.setupButton(title: "Login",
                            sizeOfText: 20,
                            wightOfText: .bold,
                            titleColor: .black,
                            cornerRad: 15)
  }
}

extension SignUPViewController {
  
  func SetUpSignUPViewController(){
    
    // Hide the error label
    errorlabel.alpha = 0
    
    // Style the elements
    firstNameTextFiled.setupTextField(firstNameTextFiled)
    lastNameTextFiled.setupTextField(lastNameTextFiled)
    emaileTextFiled.setupTextField(emaileTextFiled)
    passwordTextFiled.setupTextField(passwordTextFiled)
    
    signUpButton.setupButton(title: "Sign in ",
                             sizeOfText: 20,
                             wightOfText: .bold,
                             titleColor: .black,
                             cornerRad: 15)
  }
}

