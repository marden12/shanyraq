//
//  PasswordTextFieldView.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class PasswordTextFieldView: UITextField {
    
    var passwordHidden = true
    lazy var showBTN: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "eye_yes"), for: .normal)
        btn.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return btn
    }()
    
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 25
        self.backgroundColor = .white
        
        self.placeholder = "Type password"
        self.font = UIFont(name: Standart.myMedium.rawValue, size: 16)
        //        self.isSecureTextEntry = true
        configureViews()
        
    }
    
    func configureViews() {
        self.addSubview(showBTN)
        
        showBTN.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top).offset(19)
            make.width.equalTo(18)
            make.height.equalTo(12)
            make.right.equalTo(self.snp.right).offset(-19)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showPassword(){
        if passwordHidden {
            passwordHidden = false
            showBTN.setImage(#imageLiteral(resourceName: "eye_no"), for: .normal)
            print("hidden")
        }else{
            passwordHidden = true
            showBTN.setImage(#imageLiteral(resourceName: "eye_yes"), for: .normal)
            print(" no hidden")
        }
    }
    
}

