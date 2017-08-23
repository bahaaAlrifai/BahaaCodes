//
//  CheckOutTableViewCell.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 8/10/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class CheckOutTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var qtyTextFiled: UITextField!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
