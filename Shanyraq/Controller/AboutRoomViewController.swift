//
//  AboutRoomViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 30.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

@available(iOS 10.2, *)
@available(iOS 10.2, *)
class AboutRoomViewController: UIViewController {
    
    let screen = UIScreen.main.bounds
    var selectedIndexPath: IndexPath?
    var isHide = true
    var update = false
    var bcv = BottomCollectionViewCell()
    var firstSelected = Bool()
//    var namesArray:[Rooms] = []
    var selectedCell1 = ""
    var imagesArray:[UIImage] = []
    var namesArray:[String] = []
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BottomCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        return collectionView
    }()
    
    fileprivate lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    fileprivate lazy var collectionView2: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout2)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        return collectionView
    }()
    
    fileprivate lazy var layout2: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        var width = self.view.frame.size.width/3
        var height = self.view.frame.size.height/20
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        view.backgroundColor = .backgroundColor
        view.addSubview(collectionView)
        view.addSubview(collectionView2)
        setupNavBar()
        setupConstraints()
    }
    //nav bar config
    @available(iOS 10.2, *)
    func setupNavBar(){
        let titleFirst = CGRect(x: 0, y: 0, width: 100, height: 100)
        let titleSecond = CGRect(x: 0, y: 0, width: 300, height: 100)
        
        let titleNavigationBar = UILabel(frame: titleFirst)
        titleNavigationBar.text = "Living Room"
        titleNavigationBar.font = UIFont(name: Standart.myBold.rawValue, size: 24)
        titleNavigationBar.textColor = .black
        titleNavigationBar.sizeToFit()
        
        let editButton = UIButton(frame: titleSecond)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        editButton.setTitleColor(.newRed, for: .normal)
        editButton.backgroundColor = .clear
        editButton.sizeToFit()
        
        let addButton = UIButton(type: .custom)
        addButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        addButton.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        addButton.addTarget(self, action: #selector(addDevice), for: .touchUpInside)
        let newFont = UIFont(name: Standart.myRegular.rawValue, size: 16)!
        
        
        let leftSideView = UIBarButtonItem(customView: titleNavigationBar)
        let rightSideView = UIBarButtonItem(customView: addButton)
        var seconRightSideView = UIBarButtonItem(customView: editButton)
        seconRightSideView = editButtonItem
        
        seconRightSideView.setTitleTextAttributes([NSAttributedStringKey.font: newFont], for: .normal)
        seconRightSideView.tintColor = .newRed
        
        self.navigationItem.leftBarButtonItem = leftSideView
        self.navigationItem.rightBarButtonItems = [rightSideView,seconRightSideView]
        
        
    }
    override func setEditing (_ editing:Bool, animated:Bool){
        print("pressed")
        super.setEditing(editing,animated:animated)
        if(self.isEditing){
            let newFont = UIFont(name: Standart.myRegular.rawValue, size: 16)!
            self.editButtonItem.title = "Cancel"
            self.editButtonItem.setTitleTextAttributes([NSAttributedStringKey.font: newFont], for: .normal)
            update = true
            collectionView.reloadData()
        }else{
            self.editButtonItem.title = "Edit"
            update = false
            collectionView.reloadData()
        }
    }
    @available(iOS 10.2, *)
    @objc func addDevice(){
        let nv = AddDeviceViewController()
        nv.currenrRoom = selectedCell1
        navigationController?.present(nv, animated: true, completion: nil)
    }
    func setupConstraints(){
        self.collectionView2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/20)
        self.collectionView.frame = CGRect(x: 0, y: self.collectionView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - self.collectionView.frame.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.sizeToFit()
    }
}
@available(iOS 10.2, *)
extension AboutRoomViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! BottomCollectionViewCell
            cell.backgroundColor = .backgroundColor
            cell.update = update
            cell.roomImage.image = imagesArray[indexPath.row]
            return cell
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! TopCollectionViewCell
            cell2.backgroundColor = .white
            cell2.text.text = namesArray[indexPath.row]
            
            if indexPath.row == 0 {
                cell2.text.setBottomBorder()
                firstSelected = true
            }
            return cell2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView2{
            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            let selectedRow = collectionView.cellForItem(at: indexPath) as! TopCollectionViewCell
            selectedRow.text.setBottomBorder()
            self.selectedIndexPath = indexPath
            
        }else if collectionView == self.collectionView{
            let nv = DeviceControllingViewController()
            self.present(nv, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        let deselected = collectionView2.cellForItem(at: indexPath) as! TopCollectionViewCell
        deselected.text.setWhiteBottomBorder()
        selectedIndexPath = nil
        if (firstSelected) {
            let index = IndexPath(row: 0, section: 0)
            let deselected = collectionView2.cellForItem(at: index) as! TopCollectionViewCell
            firstSelected = false
            deselected.text.setWhiteBottomBorder()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView {
            print("\(indexPath.row)  ---> display cell")
            self.collectionView2.scrollToItem(at: indexPath, at: .right, animated: true)
            
            let selectCell = collectionView2.cellForItem(at: indexPath) as! TopCollectionViewCell
            selectCell.text.setBottomBorder()
            self.selectedCell1 = selectCell.text.text!
            print("----------->\(self.selectedCell1)")
            
            
            for i in 0...3{
                let index = IndexPath(row: i, section: 0)
                if (index != indexPath) {
                    let deselectCell = collectionView2.cellForItem(at: index) as? TopCollectionViewCell
                    deselectCell?.text.setWhiteBottomBorder()
                }
            }
            
            self.selectedIndexPath = indexPath
            
        }
    }
  
}
extension UIView {
    func setBottomBorder() {
        
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.newRed.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setWhiteBottomBorder() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.7)
        self.layer.shadowOpacity = 0.0
        self.layer.shadowRadius = 0.0
    }
}

