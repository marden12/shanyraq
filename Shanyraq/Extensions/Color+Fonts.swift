//
//  Color+Fonts.swift
//  Shanyraq
//
//  Created by Dayana Marden on 30.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit

enum Standart: String {
    case myBold = "ProximaNovaSoft-Bold"
    case myMedium = "ProximaNovaSoft-Medium"
    case myRegular = "ProximaNovaSoft-Regular"
    case mySemiBold = "ProximaNovaSoft-Semibold"
}
extension UIColor {
    static let newRed = UIColor(displayP3Red: 255/255, green: 19/255, blue: 13/255, alpha: 1)
    static let newBlue = UIColor(displayP3Red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
    static let newYellow = UIColor(displayP3Red: 254/255, green: 216/255, blue: 2/255, alpha: 1)
    static let newGray = UIColor(displayP3Red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
    static let backgroundColor = UIColor(displayP3Red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
}
