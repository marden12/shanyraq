//
//  TopCollectionViewCell.swift
//  Shanyraq
//
//  Created by Dayana Marden on 01.05.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    lazy var text: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Standart.myRegular.rawValue, size: 16)
        label.textColor = .newGray
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sizeToFit()
        self.addSubview(text)
        self.text.frame = CGRect(x: 0, y: 10, width: self.frame.width, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
