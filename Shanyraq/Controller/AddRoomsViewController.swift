//
//  AddRoomsViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class AddRoomsViewController: UIViewController {
    lazy var addPhoto: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "upload_ph"), for: .normal)
        button.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        button.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addPhotoo), for: .touchUpInside)
        return button
    }()
    lazy var titleRoom: UILabel = {
        let label = UILabel()
        label.textColor = .newRed
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        label.text = "Room name"
        return label
    }()
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "    Type name"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        view.addSubview(addPhoto)
        view.addSubview(titleRoom)
        view.addSubview(titleTextField)
        setupNavBar()
        setupConstraints()
    }
    func setupConstraints(){
        self.addPhoto.frame = CGRect(x: 0, y: 16, width: self.view.frame.width - 32, height: self.view.frame.height/3)
        self.addPhoto.center.x = self.view.center.x
        self.titleRoom.frame = CGRect(x: 16, y: self.addPhoto.frame.maxY + 16, width: self.view.frame.width/2, height: 20)
        self.titleTextField.frame = CGRect(x: 16, y: self.titleRoom.frame.maxY + 16, width: self.view.frame.width - 32,height: 50)
    }

    @objc func addPhotoo(){
        handleSelectGoodsImageView()
    }
    func loadToDatabase(){
        
    }
    //nav bar config
    func setupNavBar(){

        let titleSecond = CGRect(x: 0, y: 0, width: 300, height: 100)
        
        let editButton = UIButton(frame: titleSecond)
        editButton.setTitle("Add new room", for: .normal)
        editButton.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        editButton.setTitleColor(.newRed, for: .normal)
        editButton.backgroundColor = .clear
        editButton.sizeToFit()
        
        let newFont = UIFont(name: Standart.myRegular.rawValue, size: 16)!
        let seconRightSideView = UIBarButtonItem(customView: editButton)
        seconRightSideView.setTitleTextAttributes([NSAttributedStringKey.font: newFont], for: .normal)
        seconRightSideView.tintColor = .newRed
        
        self.navigationItem.rightBarButtonItem = seconRightSideView

        
        
    }
}
extension AddRoomsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func handleSelectGoodsImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker = UIImage()
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker as? UIImage {
            self.addPhoto.setImage(selectedImage, for: .normal)
    
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
