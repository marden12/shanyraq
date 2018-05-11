//
//  ViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 30.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
   
    let authService = AuthenticationService()
    var edit = true
    var passwordHidden = true
    
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    lazy var headerView : ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.editBNT.setTitle("Edit", for: .normal)
        view.editBNT.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        return view
    }()
    
    lazy var nameView: ProfileLabelsView = {
        let view = ProfileLabelsView()
        view.nameLabel.text = "Name"
        view.textField.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var emailView: ProfileLabelsView = {
        let view = ProfileLabelsView()
        view.nameLabel.text = "Email"
        view.textField.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var passwordView: ProfileLabelsView = {
        let view = ProfileLabelsView()
        view.nameLabel.text = "Password"
        view.textField.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var showBTN: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "eye_no"), for: .normal)
        btn.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 26)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    lazy var logOutBTN: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.newRed
        button.titleLabel?.font = UIFont(name: Standart.myBold.rawValue, size: 16)
        button.setTitle("LOG OUT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        configView()
        logOutBTN.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        userData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func configView(){
        view.addSubview(headerView)
        view.addSubview(nameView)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        passwordView.addSubview(showBTN)
        view.addSubview(logOutBTN)
        
        headerView.snp.makeConstraints{(make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(90)
        }
        
        nameView.snp.makeConstraints{(make) in
            make.top.equalTo(headerView.snp.bottom).offset(13)
            make.width.left.equalTo(headerView)
            make.height.equalTo(100)
        }
        
        
        emailView.snp.makeConstraints{(make) in
            make.top.equalTo(nameView.snp.bottom)
            make.left.width.height.equalTo(nameView)
        }
        
        passwordView.snp.makeConstraints{(make) in
            make.top.equalTo(emailView.snp.bottom)
            make.left.width.height.equalTo(nameView)
        }
        
        showBTN.snp.makeConstraints{(make) in
            make.top.equalTo(passwordView.snp.top).offset(55)
            make.width.equalTo(18)
            make.height.equalTo(12)
            make.right.equalTo(passwordView.snp.right).offset(-40)
        }
        
        logOutBTN.snp.makeConstraints{(make) in
            make.top.equalTo(passwordView.snp.bottom).offset(50)
            make.height.equalTo(50)
            make.right.equalTo(-48)
            make.left.equalTo(48)
        }
    }
    
    func userData(){
        
        let ref = Database.database().reference()
        if let userId = Auth.auth().currentUser?.uid{
            ref.child("userData").child(userId).observeSingleEvent(of: .value, with: {(snapshot) in
                if !snapshot.exists() {
                    print("data found")
                    return }
                
                let username = snapshot.childSnapshot(forPath: "username").value
                let useremail = snapshot.childSnapshot(forPath: "email").value
                let userpassword = snapshot.childSnapshot(forPath: "userpassword").value
                print(snapshot)
                self.headerView.nameLabel.text = "Hello,\(username!)"
                self.nameView.textField.text = "\(username!)"
                self.emailView.textField.text = "\(useremail!)"
                self.passwordView.textField.text = "\(userpassword!)"
            })
        }
    }
    
    @objc func editAction(){
        if edit{
            headerView.editBNT.setTitle("Edit", for: .normal)
            nameView.textField.isUserInteractionEnabled = false
            emailView.textField.isUserInteractionEnabled = false
            passwordView.textField.isUserInteractionEnabled = false
            edit = false
        }else{
            headerView.editBNT.setTitle("Done", for: .normal)
            nameView.textField.isUserInteractionEnabled = true
            emailView.textField.isUserInteractionEnabled = true
            passwordView.textField.isUserInteractionEnabled = true
            edit = true
            
        }
        //        let username = nameView.textField.text!
        //        let useremail = emailView.textField.text!
        //        let password = passwordView.textField.text!
        //        updateEmailAction(username: username, email: useremail, password: password)
    }
    
    @objc func showPassword(){
        if passwordHidden {
            showBTN.setImage(#imageLiteral(resourceName: "eye_no"), for: .normal)
            passwordView.textField.isSecureTextEntry = false
            passwordHidden = false
        }else{
            passwordHidden = true
            showBTN.setImage(#imageLiteral(resourceName: "eye_yes"), for: .normal)
            passwordView.textField.isSecureTextEntry = true
        }
    }
    
    @objc func logOutAction(){
        authService.logout()
    }
    
    /*
     func updateEmailAction(username:String,email: String,password:String) {
     let currentUser = Auth.auth().currentUser
     currentUser?.updateEmail(to: emailView.textField.text!) { error in
     if let error = error {
     print(error)
     } else {
     print("CHANGED")
     //                let uid = Auth.auth().currentUser!
     //                let thisUserRef = self.databaseRef.child("users")
     //                let thisUserEmailRef = thisUserRef.child("email")
     //                thisUserEmailRef.setValue(useremail)
     //                let uid = Auth.auth().currentUser!.uid
     //                let thisUserRef =  self.databaseRef.child("users").child(uid)
     
     //                let thisUserEmailRef = thisUserRef.child("email")
     //                thisUserEmailRef.setValue(self.emailView.textField.text!)
     
     //                let temp = ["email" : email]
     //                self.databaseRef.child("email").setValue(temp)
     let userRef = self.databaseRef.child("users")
     userRef.setValue(["username": username, "email" :  email,"password" : password])
     }
     }
     }*/
    
    
    //    func temp(email: String){
    //        let temp = ["email" : email]
    //        self.databaseRef.child(email).setValue(temp)
    //    }
}

