//
//  Banner.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/28/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import Foundation
import UIKit

class Banner {
    var bannerImage: UIImage?
    var webpageAddress: String?

    init?(bannerImage: UIImage?, webpageAddress: String? ) {
        guard !(bannerImage?.isEqual(nil))!  else {
            return nil
        }
        self.bannerImage = bannerImage
        self.webpageAddress = webpageAddress
    }
}
