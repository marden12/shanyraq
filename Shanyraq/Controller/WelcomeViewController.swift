//
//  WelcomeViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Welcome to «Shanyraq»!\nSmart Home mobile app"
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "img1")
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var signUp: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.newRed
        button.titleLabel?.font = UIFont(name: Standart.myBold.rawValue, size: 16)
        button.setTitle("CREATE NEW HOME", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var signIn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: Standart.myBold.rawValue, size: 16)
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.newRed, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 25
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 14)
        label.textColor = .newGray
        label.text = "Terms of Use & Privacy Policy"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        configView()
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
        [titleLabel,imageView,signUp,signIn, termsLabel].forEach{ view.addSubview($0) }
        
        titleLabel.snp.makeConstraints{(make) in
            make.top.equalTo(70)
            make.left.equalTo(38)
            make.height.equalTo(50)
            make.width.equalTo(300)        }
        
        imageView.snp.makeConstraints{(make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.width.height.equalTo(220)
            make.left.equalTo(77)
        }
        
        signUp.snp.makeConstraints{(make) in
            make.top.equalTo(imageView.snp.bottom).offset(36)
            make.left.equalTo(48)
            make.width.equalTo(280)
            make.height.equalTo(50)
        }
        
        signIn.snp.makeConstraints{(make) in
            make.top.equalTo(signUp.snp.bottom).offset(20)
            make.left.height.width.equalTo(signUp)
        }
        
        termsLabel.snp.makeConstraints{(make) in
            make.top.equalTo(signIn.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-100)
        }
        
    }
    
    @objc func signInAction(){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func signUpAction(){
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}

