//
//  ProductListTableViewCell.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/30/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
