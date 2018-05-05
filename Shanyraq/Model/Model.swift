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
    var image_URL: String!
    let key: String
    let ref: DatabaseReference?
    init(name: String,image_URL: String, key: String = "") {
        self.key = key
        self.name = name
        self.image_URL = image_URL
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        image_URL = snapshotValue["ImageURL"] as! String
        ref = snapshot.ref
    }
    func toAnyObject() -> Any {
        return [
            "name": name,
            "ImageURL": image_URL,
            
        ]
    }
}
struct Devices {
    var name: String!
    var image_url: String!
}



