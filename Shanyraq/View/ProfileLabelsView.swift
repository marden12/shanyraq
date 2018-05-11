//
//  ProfileLabelsView.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class ProfileLabelsView: UIView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.backgroundColor
        label.textColor = UIColor.newRed
        label.font = UIFont(name: Standart.myMedium.rawValue, size: 16)
        return label
    }()
    
    lazy var textField: TextFieldView = {
        let textField = TextFieldView()
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundColor
        self.addSubview(nameLabel)
        self.addSubview(textField)
        
        configView()
        configToolBar()
    }
    
    func configView(){
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top).offset(11)
            make.left.equalTo(self.snp.left).offset(16)
            make.width.equalTo(90)
            make.height.equalTo(16)
        }
        
        textField.snp.makeConstraints{(make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(nameLabel)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(50)
            make.bottom.equalTo(-13)
        }
    }
    
    func configToolBar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(endTextField))
        
        toolBar.setItems([flexible, doneBTN], animated: false)
        
        textField.inputAccessoryView = toolBar
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func endTextField(){
        self.endEditing(true)
    }
    
}

