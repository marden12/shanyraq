//
//  AddRoomsViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
class AddRoomsViewController: UIViewController {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
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
        self.addPhoto.frame = CGRect(x: 0, y: 80, width: self.view.frame.width - 32, height: self.view.frame.height/3)
        self.addPhoto.center.x = self.view.center.x
        self.titleRoom.frame = CGRect(x: 16, y: self.addPhoto.frame.maxY + 16, width: self.view.frame.width/2, height: 20)
        self.titleTextField.frame = CGRect(x: 16, y: self.titleRoom.frame.maxY + 16, width: self.view.frame.width - 32,height: 50)
    }

    @objc func addPhotoo(){
        handleSelectGoodsImageView()
    }
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func check(){
        if (titleTextField.text?.isEmpty)!{
            print("Emty")
        }else{
            back()
        }
        
    }

    //nav bar config
    func setupNavBar(){
        let editButton = UIButton()
        editButton.setTitle("Add new room", for: .normal)
        editButton.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        editButton.setTitleColor(.newRed, for: .normal)
        editButton.backgroundColor = .clear
        editButton.titleLabel?.textAlignment = .right
        editButton.sizeToFit()
        editButton.addTarget(self, action: #selector(check), for: .touchUpInside)
        editButton.frame = CGRect(x: self.view.frame.maxX - 230, y: 40, width: 300, height: 20)
        
        let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        backButton.frame = CGRect(x: 16, y: 40, width: 20, height: 16)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(editButton)
        self.view.addSubview(backButton)
        
        
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
//    @objc func uploadData(){
//            let image = addPhoto.imageView?.image
//            // свой image переводишь в дату
//            if let imageData = UIImageJPEGRepresentation(image!, 0.6) {
//                //upload imageData to storage
//                storageRef.child((Auth.auth().currentUser?.uid)!).child("\(titleTextField.text!)+\(String(describing: image))").putData(imageData, metadata: nil, completion: { (metadata, error) in
//                    if error != nil {
//                        print(error!.localizedDescription)
//                        print("Error")
//                    }
//                    // в сторэйдже она уже с url хранится
//                    if let ImageUrl = metadata?.downloadURL()?.absoluteString {
//                        DispatchQueue.main.async {
//
//                            if ImageUrl != "" {
//                                let userInfo = ["name": self.titleTextField.text!, "ImageURL" : ImageUrl] as [String : Any]
//                                let userRef = self.databaseRef.child("room").child((Auth.auth().currentUser?.uid)!).child(self.titleTextField.text!)
//                                _ = userRef.key
//                                userRef.setValue(userInfo)
//                            }
//                        }
//
//                    }
//                })
//            }
//        self.dismiss(animated: true, completion: nil)
//        }
    
}
