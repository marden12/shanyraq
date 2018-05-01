//
//  AddRoomsViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
class AddDeviceViewController: UIViewController {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    lazy var addPhoto: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "upload_ph"), for: .normal)
        button.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        button.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    lazy var titleRoom: UILabel = {
        let label = UILabel()
        label.textColor = .newRed
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        label.text = "Item name"
        return label
    }()
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "    Type name"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        return textField
    }()
    lazy var titleRoom2: UILabel = {
        let label = UILabel()
        label.textColor = .newRed
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        label.text = "Item code"
        return label
    }()
    lazy var titleTextField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "    Type code"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        view.addSubview(addPhoto)
        view.addSubview(titleRoom)
        view.addSubview(titleTextField)
        setupNavBar()
        setupConstraints()
    }
    func setupConstraints(){
        self.addPhoto.frame = CGRect(x: 0, y: 16, width: self.view.frame.width - 32, height: self.view.frame.height/3)
        self.addPhoto.center.x = self.view.center.x
        
        self.titleRoom.frame = CGRect(x: 16, y: self.addPhoto.frame.maxY + 16, width: self.view.frame.width/2, height: 20)
        self.titleTextField.frame = CGRect(x: 16, y: self.titleRoom.frame.maxY + 16, width: self.view.frame.width - 32,height: 50)
        
        self.titleRoom2.frame = CGRect(x: 16, y: self.titleTextField.frame.maxY + 16, width: self.view.frame.width/2, height: 20)
        self.titleTextField2.frame = CGRect(x: 16, y: self.titleRoom2.frame.maxY + 16, width: self.view.frame.width - 32,height: 50)
    }
    func addToFirebase(){
        
    }
    //nav bar config
    func setupNavBar(){
        
        let titleSecond = CGRect(x: 0, y: 0, width: 300, height: 100)
        
        let editButton = UIButton(frame: titleSecond)
        editButton.setTitle("Add new room", for: .normal)
        editButton.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        editButton.setTitleColor(.newRed, for: .normal)
        editButton.backgroundColor = .clear
        editButton.sizeToFit()
        
        let newFont = UIFont(name: Standart.myRegular.rawValue, size: 16)!
        let seconRightSideView = UIBarButtonItem(customView: editButton)
        seconRightSideView.setTitleTextAttributes([NSAttributedStringKey.font: newFont], for: .normal)
        seconRightSideView.tintColor = .newRed
        
        self.navigationItem.rightBarButtonItem = seconRightSideView
        
        
        
    }
    
}


