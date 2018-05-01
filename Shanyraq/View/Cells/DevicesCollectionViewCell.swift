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
    lazy var imageIcon: UIImageView = {
        let img = UIImageView()
        return img
    }()
    lazy var deviceName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 14)
        return label
    }()
    lazy var deviceStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 14)
        label.textColor = .newGray
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sizeToFit()
        self.addSubview(deleteButton)
        self.addSubview(imageIcon)
        self.addSubview(deviceStatus)
        self.addSubview(deviceName)
        setupConstraints()
        makeShadow(cell: self)
    }
   
    func setupConstraints(){
        self.deleteButton.frame = CGRect(x: self.frame.width - 25 , y: -10, width: 32, height: 32)
        self.imageIcon.frame.origin = CGPoint(x: 5, y: 5)
        self.deviceName.frame = CGRect(x: 5, y: 50, width: 100, height: 20)
        self.deviceStatus.frame = CGRect(x: 5, y: self.deviceName.frame.maxY, width: 100, height: 20)
        
       
        
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
