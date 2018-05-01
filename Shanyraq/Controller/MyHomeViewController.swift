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
        return layout
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupConstraints()
     
//        print((Auth.auth().currentUser?.email)!)
        [profileTitle,collectionView].forEach{
            self.view.addSubview($0)
        }
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
        navigationController?.pushViewController(nv, animated: true)
    }
    override func setEditing (_ editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
        if(self.isEditing)
        {
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
        cell.nameOfRoom.text = "Kitchen"
        cell.deleteButton.isHidden = isHide
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nv = AboutRoomViewController()
        navigationController?.pushViewController(nv, animated: true)
    }
}
