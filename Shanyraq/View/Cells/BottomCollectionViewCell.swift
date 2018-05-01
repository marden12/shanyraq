//
//  BottomCollectionViewCell.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class BottomCollectionViewCell: UICollectionViewCell {
    var isHide = true
    lazy var roomImage:UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "livroom_big_img")
        img.layer.cornerRadius = 10
        return img
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DevicesCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width:self.frame.width/4, height:self.frame.width/4)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(roomImage)
        self.addSubview(collectionView)
        self.layer.cornerRadius = 5
        setupConstraints()
        collectionView.reloadData()
        chking()
    }
    func chking(){
        if isHide == false{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }else{
            collectionView.reloadData()
        }
    }
    func setupConstraints(){
        roomImage.frame = CGRect(x: 16, y: self.frame.minY + self.frame.height/7, width: self.frame.width - 32, height: self.frame.height/3)
        collectionView.frame = CGRect(x: 16, y: self.roomImage.frame.maxY + 20, width: self.frame.width - 32, height: self.frame.height/3)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
extension BottomCollectionViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DevicesCollectionViewCell
        cell.backgroundColor = .white
        cell.deleteButton.isHidden = isHide
        print(isHide)
        return cell
    }
}
