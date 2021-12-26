//
//  Onboarding1ViewController.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 20/05/1443 AH.
//

import UIKit

class OnboardingViewController: UIViewController {
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
//    Array
    slides = [ OnboardingSlide(title: "Work according to your free time",
                               description: "Choose the job opportunities that suit you anytime, anywhere and according to your schedule ",
                               image: #imageLiteral(resourceName: "1") ) ,
               
               OnboardingSlide(title: "Add a job posting ",
                               description: "You can search for employees of all experiences and skills. ",
                               image: #imageLiteral(resourceName: "2")) ,
               
               OnboardingSlide(title: " Smart recruitment for flexible work" ,
                               description: " We connect business owners with qualified employees on flexible work contracts  ",
                               image: #imageLiteral(resourceName: "3"))
    ]
    
    setUpButton()
  }
  
  
  // MARK: - IBAction
  @IBAction func nextBtnClicked(_ sender: UIButton) {
    
    if currentPage == slides.count - 1 {
      let controller = storyboard?.instantiateViewController(withIdentifier: Constants.StoryBoard.navigationController) as! UINavigationController
      
      controller.modalPresentationStyle = .fullScreen
      controller.modalTransitionStyle = .flipHorizontal
      present(controller, animated: true, completion: nil)
    }
    else {
      currentPage += 1
      let indexPath = IndexPath(item:currentPage, section: 0)
      collictionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      
      
    }
    
  }
}
// MARK: - UICollectionView Data Source

extension OnboardingViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return slides.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =
    collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
    
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
