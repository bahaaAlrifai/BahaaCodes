//
//  ProductTableViewCell.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/27/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var priceLable: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
