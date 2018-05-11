//
//  NavBarCustomView.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
class NavBarCustomView: UIView {
    
    lazy var backBTN: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        //        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myBold.rawValue, size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundColor
        self.addSubview(backBTN)
        self.addSubview(nameLabel)
        
        backBTN.addTarget(self, action: #selector(temp), for: .touchUpInside)
        backBTN.snp.makeConstraints{(make) in
            make.top.equalTo(self.snp.top).offset(41)
            make.left.equalTo(self.snp.left).offset(24)
            make.width.equalTo(20)
            make.height.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints{(make) in
            make.top.equalTo(backBTN)
            make.left.equalTo(backBTN.snp.right).offset(55)
            make.width.equalTo(183)
        }
    }
    
    @objc func temp(){
        print("something")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

