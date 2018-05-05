//
//  RoomsCollectionViewCell.swift
//  Shanyraq
//
//  Created by Dayana Marden on 30.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
class RoomsCollectionViewCell: UICollectionViewCell {
    lazy var roomImageView: UIImageView = {
        let img = UIImageView()
//        img.image = #imageLiteral(resourceName: "bed_room")
        img.layer.cornerRadius = 10
        return img
    }()
    lazy var nameOfRoom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    lazy var numberOfItems: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        label.textColor = .white
        label.halfTextColorChange(fullText: "Items: 4", changeText: "4")
        label.textAlignment = .center
        return label
    }()
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        button.isUserInteractionEnabled = true
        button.isHidden = true
        
        return button
    }()
    var good : Rooms! {
        didSet {
                    }
    }
    
    var addPressed : Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.setupConstraints()
        self.receiveData()

    }
    func setupViews(){
        self.layer.cornerRadius = 10
        self.addSubview(roomImageView)
        self.addSubview(nameOfRoom)
        self.addSubview(numberOfItems)
        self.addSubview(deleteButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints(){
        self.roomImageView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.nameOfRoom.frame.size = CGSize(width: 100, height: 20)
        self.nameOfRoom.center = self.roomImageView.center
        self.numberOfItems.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        self.numberOfItems.center.y = self.roomImageView.center.y + 24
        self.numberOfItems.center.x = self.roomImageView.center.x
        self.deleteButton.frame = CGRect(x: self.roomImageView.frame.maxX - 25, y: self.roomImageView.frame.minY - 10, width: 32, height: 32)
        self.layer.cornerRadius = 10
        self.backgroundColor = .clear
        
    }
    func receiveData(){

    }
}
