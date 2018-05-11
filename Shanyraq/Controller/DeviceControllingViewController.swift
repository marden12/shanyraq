//
//  DeviceControllingViewController.swift
//  Shanyraq
//
//  Created by Dayana Marden on 04.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import VerticalSlider
class DeviceControllingViewController: UIViewController {
     let percentTitle = UILabel()
    lazy var slider: VerticalSlider = {
        let slider = VerticalSlider()
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slider)
        view.backgroundColor = .backgroundColor
        self.slider.frame = CGRect(x: 0, y: 64, width: 2, height: self.view.frame.height - 200)
        self.slider.center = self.view.center
        self.slider.tintColor = .newRed
        setupNavBar()
    }
    
    @objc func sliderChanged() {
        // your code here
        print(slider.value*100)
        percentTitle.text = "\(self.slider.value*100)"
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    //nav bar config
    func setupNavBar(){
        let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back_arrow"), for: .normal)
        backButton.frame = CGRect(x: 16, y: 40, width: 20, height: 16)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(backButton)
        
       

        
        
       
        percentTitle.textAlignment = .center
        percentTitle.textColor = .newRed
        percentTitle.font = UIFont(name: Standart.myBold.rawValue, size: 20)
        percentTitle.frame = CGRect(x: 0, y: 40, width: 100, height: 30)
        percentTitle.center.x = self.view.center.x
        self.view.addSubview(percentTitle)
    }
}
