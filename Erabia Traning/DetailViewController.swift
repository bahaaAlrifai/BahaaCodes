//
//  DetailViewController.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/30/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var text: String?
    var image: UIImage?
    var descriptin: String?
    var price: Int64?
    var qty: Int = 1
    var cart = [Cart]()
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qtyLabel: UITextField!

    @IBAction func decreaseButton(_ sender: UIButton) {
        qty = Int(qtyLabel.text!)!
        if qty > 1 {
            qty -= 1
        qtyLabel.text = String(describing: qty)
        }
    }

    @IBAction func increaseButton(_ sender: UIButton) {
         qty = Int(qtyLabel.text!)!
            qty += 1
        qtyLabel.text = String(describing: qty)
    }

    @IBAction func addToCart(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "", message: "Added to cart", preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil ))
        // show the alert
        self.present(alert, animated: true, completion: nil)
        cart = loadCart()
        let index = descriptin?.index((descriptin?.startIndex)!, offsetBy: 50)
        let newDescription = descriptin?.substring(to: index!)
        var found: Bool = false
        var foundRow: Int = 0
       
        if cart.count == 0 {
            found = false
        }else{
            for i in 0...cart.count - 1   {
                if cart[i].title == text! {
                    cart[i].qty! += qty
                    found = true
                    foundRow = i
                }
            }
        }
        if found == false {
            cart.insert(Cart.init(title: text!, photo: image, descriptionOfProduct: newDescription , price: price, qty: qty )!,at: 0)
        }else{
           let tempCart = cart[foundRow]
           cart.remove(at: foundRow)
           cart.insert(tempCart, at: 0)
        }
        
        saveCart()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recivedTitle = text {
            titleLabel.text = recivedTitle
        }
        if let recivedImage = image {
            photoImageView.image = recivedImage
        }
        if let recivedDescriptin = descriptin {
            descriptionTextView.text = recivedDescriptin
        }
        if let recivedPrice = price {
            priceLabel.text = ("Price: \(recivedPrice)JD ")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func saveCart() {  
        let cartData = NSKeyedArchiver.archivedData(withRootObject: cart)
        UserDefaults.standard.set(cartData, forKey: "cartData")
    }

    func loadCart() -> [Cart] {
        guard let cartData = UserDefaults.standard.object(forKey: "cartData") as? NSData else {
            print("'places' not found in UserDefaults")
            return []
        }
        guard let cart = (NSKeyedUnarchiver.unarchiveObject(with: cartData as Data) as? [Cart]) else {
            print("Could not unarchive from cartData")
            return []
        }
        return cart
    }
}
