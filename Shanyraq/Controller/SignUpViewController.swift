//
//  SignUpViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import ProgressHUD

class SignUpViewController: UIViewController {
    
    let authService = AuthenticationService()
    var passwordHidden = true
    
    
    lazy var backBTN: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        //        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 20)
        label.textColor = .black
        label.text = "Register New Home"
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "img3")
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var homeName: TextFieldView = {
        let textField = TextFieldView()
        textField.placeholder = "Type Home name"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var homeEmail: TextFieldView = {
        let textField = TextFieldView()
        textField.placeholder = "Type email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var homePassword: TextFieldView = {
        let textField = TextFieldView()
        textField.placeholder = "Type Password"
        return textField
    }()
    
    lazy var showBTN: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "eye_no"), for: .normal)
        btn.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var registrBTN: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.backgroundColor
        button.titleLabel?.font = UIFont(name: Standart.myBold.rawValue, size: 16)
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        button.setTitleColor(UIColor.newRed, for: .normal)
        
        return button
    }()
    
    lazy var haveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 14)
        label.textColor = UIColor.newGray
        label.textAlignment = .center
        label.text = "Already have a Home?"
        return label
    }()
    
    lazy var logInBTN: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.newRed
        button.titleLabel?.font = UIFont(name: Standart.myBold.rawValue, size: 16)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registrAction), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        homePassword.isSecureTextEntry = true
        configView()
        configToolBar()
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
        [titleLabel,backBTN,imageView,homeName,homeEmail,homePassword,registrBTN,haveAccountLabel,logInBTN,showBTN].forEach{ view.addSubview($0) }
        
        backBTN.snp.makeConstraints{(make) in
            make.top.equalTo(view.snp.top).offset(41)
            make.left.equalTo(view.snp.left).offset(24)
            make.width.equalTo(20)
            make.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints{(make) in
            make.top.equalTo(backBTN)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(183)
        }
        
        imageView.snp.makeConstraints{(make) in
            make.top.equalTo(96)
            make.left.equalTo(111)
            make.height.equalTo(120)
            make.width.equalTo(138)
        }
        
        homeName.snp.makeConstraints{(make) in
            make.top.equalTo(imageView.snp.bottom).offset(35)
            make.width.equalTo(280)
            make.height.equalTo(50)
            make.left.equalTo(48)
        }
        
        homeEmail.snp.makeConstraints{(make) in
            make.top.equalTo(homeName.snp.bottom).offset(20)
            make.left.width.height.equalTo(homeName)
        }
        
        homePassword.snp.makeConstraints{(make) in
            make.top.equalTo(homeEmail.snp.bottom).offset(20)
            make.left.width.height.equalTo(homeName)
        }
        
        logInBTN.snp.makeConstraints{(make) in
            make.top.equalTo(homePassword.snp.bottom).offset(60)
            make.left.width.height.equalTo(homeName)
        }
        
        haveAccountLabel.snp.makeConstraints{(make) in
            make.top.equalTo(logInBTN.snp.bottom).offset(20)
            make.left.equalTo(117)
            make.width.equalTo(142)
            make.height.equalTo(17)
        }
        registrBTN.snp.makeConstraints{(make) in
            make.top.equalTo(haveAccountLabel.snp.bottom).offset(7)
            make.left.equalTo(159)
            make.bottom.equalTo(view.snp.bottom).offset(-52)
        }
        
        showBTN.snp.makeConstraints{(make) in
            make.top.equalTo(homePassword.snp.top).offset(19)
            make.width.equalTo(18)
            make.height.equalTo(12)
            make.right.equalTo(homePassword.snp.right).offset(-19)
        }
        
        backBTN.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    func configToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(endTextField))
        
        toolBar.setItems([flexible, doneBTN], animated: false)
        homeName.inputAccessoryView = toolBar
        homeEmail.inputAccessoryView = toolBar
        homePassword.inputAccessoryView = toolBar
        
    }
    
    @objc func showPassword(){
        if passwordHidden {
            passwordHidden = false
            showBTN.setImage(#imageLiteral(resourceName: "eye_no"), for: .normal)
            homePassword.isSecureTextEntry = true
        }else{
            passwordHidden = true
            showBTN.setImage(#imageLiteral(resourceName: "eye_yes"), for: .normal)
            homePassword.isSecureTextEntry = false
        }
    }
    
    @objc func registrAction(){
        let name = homeName.text!
        let email = homeEmail.text!
        let password = homePassword.text!
        
        if name.isEmpty || email.isEmpty || password.isEmpty{
            ProgressHUD.showError("Check your email or password,please")
        }else{
            authService.signUp(username: name, email: email, password: password, vc: self)
            ProgressHUD.show("Waiting", interaction: false)
        }
    }
    
    @objc func signInAction(){
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func backAction(){
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func endTextField(){
        view.endEditing(true)
    }
    
}

