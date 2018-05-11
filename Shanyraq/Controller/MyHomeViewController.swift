//
//  myHomeViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 30.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CoreData

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.newRed , range: range)
        self.attributedText = attribute

    }
}
class MyHomeViewController: UIViewController {
    var numberApha = 0
    var isHide = true
    
    var roomsArray: [Rooms] = []
    var roomsData : [RoomsData] = []
    var imagesArray = [#imageLiteral(resourceName: "kitchen_room"),#imageLiteral(resourceName: "living_room"),#imageLiteral(resourceName: "bed_room")]
    var textArray = ["Kitchen","Living Room","BedRoom"]
    var image_url: String = ""
    var databaseRef: DatabaseReference!{
        return Database.database().reference()
    }
    var array: [String] = []
    var array2: [String] = []
    lazy var profileTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 20)
        label.textColor = .newGray
        label.halfTextColorChange(fullText: "Your rooms : 3", changeText: "3")
        label.textAlignment = .center
        return label
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoomsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:self.view.frame.width/2 - 25, height:self.self.view.frame.width/2 - 25)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.sectionInset.bottom = 100
        return layout
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupConstraints()
        [profileTitle,collectionView].forEach{
            self.view.addSubview($0)
        }
        collectionView.reloadData()


    }


    func fetchData(){
        print("fetchData")
        self.roomsArray.removeAll()
        databaseRef.child("room").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: {
            snapshot in
            
                let snapshotValue = snapshot.value as? NSDictionary
                let name = snapshotValue?["name"] as? String
                let photoUrl = snapshotValue?["ImageURL"] as? String
                DispatchQueue.main.async {
                    let model  = Rooms(name: name!,image_URL: photoUrl!)
                    self.roomsArray.insert(model, at: 0)
                    print(self.roomsArray)
                    self.collectionView.reloadData()
                    
                }

        })
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
//nav bar config
    func setupNavBar(){
        let titleFirst = CGRect(x: 0, y: 0, width: 100, height: 100)
        let titleSecond = CGRect(x: 0, y: 0, width: 300, height: 100)
        
        let titleNavigationBar = UILabel(frame: titleFirst)
        titleNavigationBar.text = "All rooms"
        titleNavigationBar.font = UIFont(name: Standart.myBold.rawValue, size: 24)
        titleNavigationBar.textColor = .black
        titleNavigationBar.sizeToFit()
        
        let editButton = UIButton(frame: titleSecond)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        editButton.setTitleColor(.newRed, for: .normal)
        editButton.backgroundColor = .clear
        editButton.sizeToFit()
        
        let addButton = UIButton(type: .custom)
        addButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        addButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        addButton.addTarget(self, action: #selector(addRoom), for: .touchUpInside)
        let newFont = UIFont(name: Standart.myRegular.rawValue, size: 16)!

        
        let leftSideView = UIBarButtonItem(customView: titleNavigationBar)
        let rightSideView = UIBarButtonItem(customView: addButton)
        var seconRightSideView = UIBarButtonItem(customView: editButton)
        seconRightSideView = editButtonItem
        
        seconRightSideView.setTitleTextAttributes([NSAttributedStringKey.font: newFont], for: .normal)
        seconRightSideView.tintColor = .newRed
        
        self.navigationItem.leftBarButtonItem = leftSideView
        self.navigationItem.rightBarButtonItems = [rightSideView,seconRightSideView]
        
        
    }
    @objc func addRoom(){
        let nv = AddRoomsViewController()
        self.present(nv, animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        self.collectionView.reloadData()
    }
    override func setEditing (_ editing:Bool, animated:Bool){
        super.setEditing(editing,animated:animated)
        if(self.isEditing){
            let newFont = UIFont(name: Standart.myRegular.rawValue, size: 16)!
            self.editButtonItem.title = "Cancel"
            self.editButtonItem.setTitleTextAttributes([NSAttributedStringKey.font: newFont], for: .normal)
            isHide = false
            collectionView.reloadData()
        }else{
            self.editButtonItem.title = "Edit"
            
            isHide = true
            collectionView.reloadData()
        }
    }
  

    
//constraints
    func setupConstraints(){
        self.profileTitle.frame = CGRect(x: 0, y: 16, width: self.view.frame.width/2, height: self.view.frame.height/12)
        self.profileTitle.center.x = self.view.center.x
        self.collectionView.frame = CGRect(x: 0, y: self.profileTitle.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
    }

    
}
extension MyHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RoomsCollectionViewCell
    
        cell.nameOfRoom.text = textArray[indexPath.row]
        cell.deleteButton.isHidden = isHide
        cell.roomImageView.image = imagesArray[indexPath.row]

        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nv = AboutRoomViewController()
        nv.namesArray = textArray
        nv.imagesArray = imagesArray
        navigationController?.pushViewController(nv, animated: true)
    }
    @objc func deleteRoom(index: Int){
        roomsArray.remove(at: index)
        self.collectionView.reloadData()
    }
}
