//
//  DevicesCollectionViewCell.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class DevicesCollectionViewCell: UICollectionViewCell {
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        button.isUserInteractionEnabled = true
        button.isHidden = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sizeToFit()
        self.addSubview(deleteButton)
        setupConstraints()
        makeShadow(cell: self)
    }
   
    func setupConstraints(){
        self.deleteButton.frame = CGRect(x: self.frame.width - 25 , y: -10, width: 32, height: 32)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeShadow(cell: UICollectionViewCell){
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.newGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }
}
