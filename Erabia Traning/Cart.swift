//
//  Cart.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 8/8/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import Foundation
import UIKit


class Cart: NSObject, NSCoding {
    var title: String
    var photo: UIImage?
    var descriptionOfProduct: String?
    var price: Int64?
    var qty: Int?
    
    init?(title: String, photo: UIImage?, descriptionOfProduct: String?,price: Int64?, qty: Int?) {
        guard !title.isEmpty else {
            return nil
        }
        self.title = title
        self.photo = photo
        self.descriptionOfProduct = descriptionOfProduct
        self.price = price
        self.qty = qty
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.descriptionOfProduct = (aDecoder.decodeObject(forKey: "descriptionOfProduct")as? String)!
        self.photo = aDecoder.decodeObject(forKey: "photo") as? UIImage
        self.title = (aDecoder.decodeObject(forKey: "title") as? String)!
        self.price = (aDecoder.decodeObject(forKey: "price")) as? Int64!
        self.qty = (aDecoder.decodeObject(forKey: "qty")) as? Int!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(descriptionOfProduct, forKey: "descriptionOfProduct")
        aCoder.encode(photo, forKey: "photo")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(qty, forKey: "qty")
    }
}
