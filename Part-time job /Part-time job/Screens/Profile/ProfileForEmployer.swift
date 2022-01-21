//
//  ProfileForEmployer.swift
//  Part-time job
//
//  Created by ABRAR ALQARNI on 22/05/1443 AH.
//


import UIKit
import Firebase

class ProfileForEmployer: UIViewController {
  
  //  MARK: - Properties
  fileprivate let db = Firestore.firestore()
  fileprivate let storage = Storage.storage()
  private var user = [User]()
  private var jobs = [Job]()
  
  private let scrollView  = UIScrollView()
  private let contentView = UIView()
  
  var collectionView: UICollectionView!
  
  
  //  MARK: - @IBOutlet
  private let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(EmployerProfileCell.self,
                   forCellReuseIdentifier: EmployerProfileCell.id)
    
    return table
  }()
  
  private let nameHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Name"
    return lbl
  }()
  
  
  private let nameLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    return lbl
  }()
  
  private let emailHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Your Email"
    return lbl
  }()
  
  
  private let emailLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobText
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = ""
    lbl.textAlignment = .left
    return lbl
  }()
  
  private let applicantsHeader: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .jobActionColors
    lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.text = "Applicants: "
    lbl.textAlignment = .left
    return lbl
  }()
  
  //MARK: - View controller life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Profile"
    view.backgroundColor = .jobBackgroundColor
    navigationItem.largeTitleDisplayMode = .never
    
    //    logout
    let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    logoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")!.withTintColor(.systemRed.withAlphaComponent(0.57)).withRenderingMode(.alwaysOriginal), for: .normal)
    logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    
    //func
    setupScrollView()
    setupViews()
    setupCollectionView()
    setupTB()
    getCurrentUserInfo()
    
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+605)
    getUsersData()
    getJobAdvertisements()
  }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 350)
  }
  
  
  
  private func setupScrollView(){
    scrollView.isScrollEnabled = true
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    
    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    
  }
  
  //Alert
  @objc private func logout() {
    let alert = UIAlertController(title: "Log out", message: "Your sure you want to log out?",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "LOG OUT", style: .destructive,
                                  handler: { _ in
      do {
        try Auth.auth().signOut()
        self.dismiss(animated: true, completion:nil)
        
      }
      catch let signOutError {
        let alert = UIAlertController(title: "Error", message: signOutError.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
      }
      
    }))
    
    alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
  }
  
  //  constraints
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: CGRect(x: 0, y: 450, width: contentView.frame.size.width, height: 600), collectionViewLayout: generateLayout())
    collectionView.autoresizingMask     = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor      = .jobBackgroundColor
    collectionView.delegate             = self
    collectionView.dataSource           = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(EmployerCollectionProfileCell.self, forCellWithReuseIdentifier: EmployerCollectionProfileCell.id)
    scrollView.addSubview(collectionView)
    scrollView.isUserInteractionEnabled = true
    contentView.isUserInteractionEnabled = true
  }
  
  
  private func generateLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout{ (sectionNum, env )-> NSCollectionLayoutSection? in
      
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
      
      item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
      
      let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(255)), subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      
      return section
    }
  }
  
  
  private func getUsersData() {
    guard let user = Auth.auth().currentUser else {return}
    
    db.collection("PeopleToInterview").whereField("employerID", isEqualTo: user.uid).getDocuments { sn, err in
      if let err = err {
        print("error happened \(err)")
      }else {
        self.user = []
        if sn!.documents.isEmpty {
          self.user.append(User(name: "There are no applicants yet!.",
                                email: "",
                                age: "",
                                degree: "",
                                experience: "")
          )
          DispatchQueue.main.async {
            self.tableView.reloadData()
          }
        }
        for doc in sn!.documents {
          let data = doc.data()
          
          self.user.append(User(name: data["name"] as? String ?? "No name available",
                                email: data["email"] as? String ?? "No email available",
                                age: data["age"] as? String ?? "No age available",
                                degree: data["degree"] as? String ?? "No degree available",
                                experience: data["experience"] as? String ?? "No experience available")
          )
          
          
        }
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
        
      }
      
    }
    
  }
  
  
  private func getCurrentUserInfo() {
    guard let user = Auth.auth().currentUser else {return}
    var name = ""
    var email = ""
    print("this is the current user id \(user.uid)")
    db.collection("Users").whereField("userID", isEqualTo: user.uid).getDocuments { sn, err in
      if let err = err {
        print("error happened \(err)")
      }else {
        
        for doc in sn!.documents {
          let data = doc.data()
          name = data["name"] as? String ?? "No name available"
          email = data["email"] as? String ?? "No email available"
          
        }
        DispatchQueue.main.async {
          
          self.nameLabel.text = name
          self.emailLabel.text = email
          
          
        }
      }
      
    }
    
  }
  
  
  private func setupViews() {
    
    view.addSubview(nameHeader)
    view.addSubview(nameLabel)
    view.addSubview(emailHeader)
    view.addSubview(emailLabel)
    view.addSubview(applicantsHeader)
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      
      nameHeader.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
      nameHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      
      nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: nameHeader.trailingAnchor, constant: 10),
      
      
      
      emailHeader.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      emailHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      
      emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      emailLabel.leadingAnchor.constraint(equalTo: emailHeader.trailingAnchor, constant: 10),
      
      
      applicantsHeader.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
      applicantsHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      
      tableView.topAnchor.constraint(equalTo: applicantsHeader.bottomAnchor, constant: 10),
      tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      tableView.heightAnchor.constraint(equalToConstant: 250),
    ])
  }
  
  
  private func setupTB(){
    tableView.rowHeight = 150
    tableView.register(EmployerProfileCell.self, forCellReuseIdentifier: EmployerProfileCell.id)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .jobBackgroundColor
    
  }
}

//  MARK: - Table View Data Source

extension ProfileForEmployer: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return user.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("called ")
    let cell = tableView.dequeueReusableCell(withIdentifier: EmployerProfileCell.id, for: indexPath) as! EmployerProfileCell
    
    cell.name.text = user[indexPath.row].name
    cell.age.text = user[indexPath.row].age
    cell.experience.text = user[indexPath.row].experience
    cell.email.text = user[indexPath.row].email
    cell.degree.text = user[indexPath.row].degree
    return cell
  }
}

//  MARK: - Collection View Data Source

extension ProfileForEmployer: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmployerCollectionProfileCell.id, for: indexPath) as! EmployerCollectionProfileCell
    cell.setCell(job: jobs[indexPath.row])
    readImageFromFirestore(with: jobs[indexPath.row].imageURL) { image in
      DispatchQueue.main.async {
        cell.imageForJob.image = image
      }
      
    }
    cell.backgroundColor = .blue
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return jobs.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.collectionView.deleteItems(at: [indexPath])
    self.deleteData(for: self.jobs[indexPath.row].docID)
    self.jobs.remove(at: indexPath.row)
  }
  
  
  private func deleteData(for document: String) {
    db.collection("Jobs").document(document).delete { err in
      
      if let err = err {
        print("Error removing document: \(err)")
      } else {
        print("Document successfully removed!")
        DispatchQueue.main.async {
          self.collectionView.reloadData()
          
        }
      }
      
    }
  }
  
  
  private func readImageFromFirestore(with url: String, completion: @escaping (UIImage)-> ()) {
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
  
  
  private func getJobAdvertisements(){
    guard let user = Auth.auth().currentUser else {return}
    db.collection("Jobs").whereField("userID", isEqualTo: user.uid).getDocuments { (querySnapshot, error) in
      
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
          print("Hello!! \(self.jobs.count)")
        }
        
        DispatchQueue.main.async {
          
          self.collectionView.reloadData()
          
        }
        
      }
    }
  }
  
}
