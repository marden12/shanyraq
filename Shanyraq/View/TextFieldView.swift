//
//  TextFieldView.swift
//  Shanyraq
//
//  Created by Dayana Marden on 05.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class TextFieldView: UITextField,UITextFieldDelegate {
    
    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.placeholder = ""
        self.font = UIFont(name: Standart.myMedium.rawValue, size: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
}
