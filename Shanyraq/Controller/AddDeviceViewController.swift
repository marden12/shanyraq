//
//  AddRoomsViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
@available(iOS 10.2, *)
class AddDeviceViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var databaseRef: DatabaseReference! {
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    var currenrRoom = ""
    let systemSoundId : SystemSoundID = 1016
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    lazy var addPhoto: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "scan_qr"), for: .normal)
        button.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        button.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(scanCode), for: .touchUpInside)
        return button
    }()
    lazy var titleRoom: UILabel = {
        let label = UILabel()
        label.textColor = .newRed
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        label.text = "Item name"
        return label
    }()
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "    Type name"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        return textField
    }()
    lazy var titleRoom2: UILabel = {
        let label = UILabel()
        label.textColor = .newRed
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        label.text = "Item code"
        return label
    }()
    lazy var titleTextField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "    Type code"
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
        view.addSubview(titleRoom2)
        view.addSubview(titleTextField2)
    
        setupNavBar()
        setupConstraints()
    }
    func setupConstraints(){
        self.addPhoto.frame = CGRect(x: 0, y: 80, width: self.view.frame.width - 32, height: self.view.frame.height/3)
        self.addPhoto.center.x = self.view.center.x
        self.titleRoom.frame = CGRect(x: 16, y: self.addPhoto.frame.maxY + 16, width: self.view.frame.width/2, height: 20)
        self.titleTextField.frame = CGRect(x: 16, y: self.titleRoom.frame.maxY + 16, width: self.view.frame.width - 32,height: 50)
        
        self.titleRoom2.frame = CGRect(x: 16, y: self.titleTextField.frame.maxY + 16, width: self.view.frame.width/2, height: 20)
        self.titleTextField2.frame = CGRect(x: 16, y: self.titleRoom2.frame.maxY + 16, width: self.view.frame.width - 32,height: 50)
    }
    func addToFirebase(){
        
    }

    @objc func scanCode() {
        addCapture()
    }
    
    func addCapture(){
        //AVCaptureDevice allows us to reference a physical capture device (video in our case)
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let captureDevice = captureDevice {
            
            do {
                
                captureSession = AVCaptureSession()
                
                // CaptureSession needs an input to capture Data from
                let input = try AVCaptureDeviceInput(device: captureDevice)
                captureSession?.addInput(input)
                
                // CaptureSession needs and output to transfer Data to
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession?.addOutput(captureMetadataOutput)
                
                //We tell our Output the expected Meta-data type
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = [.code128, .qr,.ean13, .ean8, .code39, .upce, .aztec, .pdf417] //AVMetadataObject.ObjectType
                
                captureSession?.startRunning()
                
                //The videoPreviewLayer displays video in conjunction with the captureSession
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                view.bringSubview(toFront: titleTextField2)
            }
                
                
            catch {
                
                print("Error")
                
            }
        }
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            print("no objects returned")
            return
        }
        
        let metaDataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        guard let StringCodeValue = metaDataObject.stringValue else {
            return
        }
        
        
        //transformedMetaDataObject returns layer coordinates/height/width from visual properties
        guard (videoPreviewLayer?.transformedMetadataObject(for: metaDataObject)) != nil else {
            return
        }
        
        //Those coordinates are assigned to our codeFrame
        AudioServicesPlayAlertSound(systemSoundId)
        let fullName    = StringCodeValue
        let fullNameArr = fullName.components(separatedBy: ",")
        
        titleTextField.text = fullNameArr[0]
        titleTextField2.text = fullNameArr[1]
        
        
        if let url = URL(string: StringCodeValue) {
            captureSession?.stopRunning()
            videoPreviewLayer?.session?.stopRunning()
            videoPreviewLayer?.removeFromSuperlayer()
        }
    }
    @objc func addToDatabase(){
        if titleTextField2.text == "" && titleTextField.text == ""{
            print("Error")
        }else{
            let user = Auth.auth().currentUser?.uid
            let userRef = databaseRef.child("devices").child((user)!).child(self.currenrRoom)
            let devices = ["name": titleTextField.text,"image": titleTextField2.text]
            userRef.setValue(devices)
        }
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    //nav bar config
    func setupNavBar(){
        let editButton = UIButton()
        editButton.setTitle("Add new device", for: .normal)
        editButton.titleLabel?.font = UIFont(name: Standart.myRegular.rawValue, size: 18)
        editButton.setTitleColor(.newRed, for: .normal)
        editButton.backgroundColor = .clear
        editButton.titleLabel?.textAlignment = .right
        editButton.sizeToFit()
        editButton.addTarget(self, action: #selector(addToDatabase), for: .touchUpInside)
        editButton.frame = CGRect(x: self.view.frame.maxX - 230, y: 40, width: 300, height: 20)
        
        let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        backButton.frame = CGRect(x: 16, y: 40, width: 20, height: 16)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(editButton)
        self.view.addSubview(backButton)
        
        
    }
   
}


