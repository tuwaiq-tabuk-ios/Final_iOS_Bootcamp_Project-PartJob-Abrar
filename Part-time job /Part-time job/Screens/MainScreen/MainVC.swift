//
//  MainVC.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class MainVC: UIViewController {
  
  //  //MARK: - Properties
  fileprivate let db = Firestore.firestore()
  fileprivate let storage = Storage.storage()
  var collectionView: UICollectionView!
  var jobs = [Job]()
  
  
  private let createAdButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.setupButton(with: "Create Job")
    btn.isHidden = true
    btn.addTarget(self, action: #selector(createJobTapped), for: .touchUpInside)
    return btn
  }()
  
  //   //MARK: - View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    setupUserInterface()
    
    
    let profileButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    profileButton.setImage(UIImage(systemName: "person.fill")!.withTintColor(.jobActionColors!).withRenderingMode(.alwaysOriginal), for: .normal)
    profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if !isUserIsSignedIn() {
      showSignInVC()
    }else{
      print("called viewDidAppear")
      getFSJobOffersFS()
      
      isUserEmployer { [weak self] isEmployer in
        if isEmployer == "yes" {
          DispatchQueue.main.async {
            self?.createAdButton.isHidden = false
          }
        }else if isEmployer == "no"{
          DispatchQueue.main.async {
            self?.createAdButton.isHidden = true
          }
        }
      }
    }
  }
  
  
  @objc private func profileButtonTapped() {
    isUserEmployer { [weak self] isEmployer in
      if isEmployer == "yes" {
        DispatchQueue.main.async {
          self?.navigationController?.pushViewController(ProfileForEmployer(), animated: true)
        }
      }else if isEmployer == "no"{
        DispatchQueue.main.async {
          self?.navigationController?.pushViewController(ProfileForEmployee(), animated: true)
        }
      }
    }
  }
  
  
  private func setupUserInterface() {
    view.addSubview(createAdButton)
    
    NSLayoutConstraint.activate([
      
      createAdButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      createAdButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
      createAdButton.widthAnchor.constraint(equalToConstant: 100),
      createAdButton.heightAnchor.constraint(equalToConstant: 40),
      
    ])
  }
  
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .jobBackgroundColor
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.id)
    view.addSubview(collectionView)
  }
  
  
  //sheek user
  private func isUserIsSignedIn() -> Bool {
    return Auth.auth().currentUser != nil
  }
  
  
  private func showSignInVC() {
    let vc = UINavigationController(rootViewController: LoginVC())
    vc.modalTransitionStyle = .coverVertical
    vc.modalPresentationStyle = .fullScreen
    self.navigationController?.present(vc, animated: true, completion: nil)
  }
  
  
  private func isUserEmployer(completion: @escaping (String) -> ()){
    guard let user = Auth.auth().currentUser else {return}
    db.collection("Users").whereField("userID", isEqualTo: user.uid)
      .getDocuments { (querySnapshot, error) in
        
        if let e = error {
          print("There was an issue retrieving data from Firestore. \(e)")
        } else {
          
          if querySnapshot!.documents.isEmpty {
            completion("no")
          }else{
            for document in querySnapshot!.documents{
              let data = document.data()
              completion(data["isEmployer"] as? String ?? "no")
            }
          }
        }
      }
  }
  
  //Data
  private func getFSJobOffersFS(){
    
    db.collection("Jobs").addSnapshotListener { (querySnapshot, error) in
      
      if let e = error {
        print("There was an issue retrieving data from Firestore. \(e)")
      } else {
        
        self.jobs = []
        
        for document in querySnapshot!.documents{
          let data = document.data()
          
          self.jobs.append(
            Job(imageURL: data["imageURL"] as? String ?? "NA",
                companyName: data["companyName"] as? String ?? "NA",
                jobTitle: data["jobTitle"] as? String ?? "NA",
                city: data["city"] as? String ?? "NA", location: data["location"] as? String ?? "NA",
                duration: data["duration"] as? String ?? "NA",
                amountOfMoney: data["salary"] as? String ?? "NA",
                jobDescription: data["description"] as? String ?? "There is no description for this job", userID: data["userID"] as? String ?? "NA", docID: data["docID"] as? String ?? "NA")
          )
        }
        
        DispatchQueue.main.async {
          
          self.collectionView.reloadData()
          
        }
      }
    }
  }
  
  
  private func generateLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout{ (sectionNum, env )-> NSCollectionLayoutSection? in
      
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
      
      item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
      
      let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(320)), subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      
      return section
    }
  }
  
  
  
  
  @objc private func createJobTapped() {
    self.navigationController?.pushViewController(AddJobVC(), animated: true)
  }
  
  
}//end class


//MARK: - Collection View Data Source

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.id, for: indexPath) as! MainCell
    cell.setCell(job: jobs[indexPath.row])
    readImageFromFirestore(with: jobs[indexPath.row].imageURL) { image in
      DispatchQueue.main.async {
        cell.imageForJob.image = image
      }
      
    }
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)-> Int {
    return jobs.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? MainCell else { return }
    let vc = JobDetailVC()
    vc.job = jobs[indexPath.row]
    vc.imageView.image = cell.imageForJob.image ?? UIImage()
    vc.title = jobs[indexPath.row].companyName
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  
  private func readImageFromFirestore(with url: String, completion: @escaping (UIImage)-> ()){

    if  url != "NA" {
    
      print(url)
      let httpsReference = self.storage.reference(forURL: url)
      
      httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
        if let error = error {
          print("ERROR GETTING DATA \(error.localizedDescription)")
        } else {
          
          completion(UIImage(data: data!) ?? UIImage())
          
        }
      }
    }
  }
}
