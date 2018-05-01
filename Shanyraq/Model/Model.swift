//
//  Model.swift
//  Shanyraq
//
//  Created by Dayana Marden on 30.04.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
struct Rooms {
    var name: String!
    var items: [String]!
    var image: UIImage!
    var image_url: String!
}
class Goods {
    
    var name: String!
    var images: UIImage!
    var imageURLs: String!
    init(snapshot: DataSnapshot) {
        let json = JSON(snapshot.value!)
        self.name = json["name"].stringValue
        self.imageURLs = json["profileImageURLs"].stringValue
    }
    
    init(name: String, surname: String,images: UIImage,imageURLs: String) {
        self.name = name
        self.images = images
        self.imageURLs = imageURLs
    }
    
    
    
  
    
}


