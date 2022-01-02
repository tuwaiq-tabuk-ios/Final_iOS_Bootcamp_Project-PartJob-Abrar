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
    findAJobButton.setupButton(title: "Find a job",
                          sizeOfText: 20,
                          wightOfText: .black,
                          titleColor: .white,
                          cornerRad: 15)
    
      businessownerButton.setupButton(title: "Add a job offer " ,
                           sizeOfText: 20,
                           wightOfText: .bold,
                           titleColor: .black,
                           cornerRad: 15)
    
    askAboutJoin.setupLable(titleLabel: "Hi I'm looking to...",
                            backgrounC: .clear,
                            sizeOfText: 31,
                            wightOfText: .bold,
                            alignText: .center)
    
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


extension StartViewController{
  
  func SetUpStartViewController() {
    // Style the elements
    startPressedButton.setupButton(title: "Start Now" ,
                                   sizeOfText: 20,
                                   wightOfText: .bold,
                                   titleColor: .white,
                                   cornerRad: 15)
    
  }
  
}

extension OnboardingViewController {
  
  func setUpButton() {
    // Style the Buttun
    nextBtn.setupButton(title: "Next",
                        sizeOfText: 20,
                        wightOfText: .bold,
                        titleColor: .white,
                        cornerRad: 15)
  }
  
  
}
extension BOSignUpVC {
  
  func SetUpBOSignUpVC(){
    
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

extension BOLoginVC {
  
  func SetUpBOLoginVC(){
    
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

extension BOHomeVC {
  
  func SetUpBOHomeVC(){

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
