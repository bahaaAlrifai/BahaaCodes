//
//  CartTableViewCell.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 8/8/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var quantityLabel: UITextField!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}




