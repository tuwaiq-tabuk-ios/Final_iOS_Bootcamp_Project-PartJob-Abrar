//
//  Onboarding1ViewController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 20/05/1443 AH.
//

import UIKit

class OnboardingVC: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var collictionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var nextBtn: UIButton!
  
  var slides: [OnboardingSlide] = []
  
  var currentPage = 0 {
    didSet {
      pageControl.currentPage = currentPage
      if currentPage == slides.count - 1 {
        nextBtn.setTitle("Get Started", for: .normal)
      } else {
        nextBtn.setTitle("Next", for: .normal)
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Array
    slides = [ OnboardingSlide(title: "Work in your free time",
                               description: "Choose the job opportunities that suit you anytime, anywhere.",
                               image: #imageLiteral(resourceName: "1") ) ,
               
               OnboardingSlide(title: "Add a job offer ",
                               description: "You can search for employees of all experiences and skills. ",
                               image: #imageLiteral(resourceName: "2")) ,
               
               OnboardingSlide(title: " Smart recruitment for flexible work" ,
                               description: "We connect employer with qualified employees on flexible work contracts",
                               image: #imageLiteral(resourceName: "3"))
    ]
    
    
  }
  
  
  // MARK: - IBAction
  @IBAction func nextBtnPressed(_ sender: UIButton) {
    
    if currentPage == slides.count - 1 {
  
      transitionToLoginVC()
  
    }
    else {
      currentPage += 1
      let indexPath = IndexPath(item:currentPage, section: 0)
      collictionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  
    }
    
  }
  
    func transitionToLoginVC() {
      let controller = self.storyboard?.instantiateViewController(withIdentifier: K.StoryBoard.loginScreen) as! UINavigationController

      controller.modalPresentationStyle = .fullScreen
      controller.modalTransitionStyle = .flipHorizontal
      self.present(controller, animated: true, completion: nil)

    
  }
}





// MARK: - UICollectionView Data Source

extension OnboardingVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return slides.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
    collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCell
    
    cell.setup(slides[indexPath.row])
    return cell
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    return CGSize(width: collictionView.frame.width ,
                  height: collictionView.frame.height)
  }
  
  //  Update Scroll
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let width = scrollView.frame.width
    currentPage = Int(scrollView.contentOffset.x / width )
    
  }
  
  
}
