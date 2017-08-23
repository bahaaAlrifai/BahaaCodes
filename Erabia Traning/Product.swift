//
//  Product.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/27/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import Foundation
import UIKit


class Product{
    var title: String
    var photo: UIImage?
    var description: String?
    var price: Int64?

    init?(title: String, photo: UIImage?, description: String?,price: Int64?) {
        guard !title.isEmpty else {
            return nil
        }
        self.title = title
        self.photo = photo
        self.description = description
        self.price = price
    }
}
