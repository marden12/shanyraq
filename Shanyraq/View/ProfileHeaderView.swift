//
//  ProfileHeaderView.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 26)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    lazy var editBNT: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont(name: Standart.myBold.rawValue, size: 16)
        btn.setTitleColor(UIColor.newRed, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(nameLabel)
        self.addSubview(editBNT)
        
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top).offset(44)
            make.left.equalTo(self.snp.left).offset(24)
        }
        
        editBNT.snp.makeConstraints{(make) in
            make.top.equalTo(nameLabel)
            make.right.equalTo(self.snp.right).offset(-24)
            make.width.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

