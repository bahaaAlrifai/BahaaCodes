//
//  CartViewController.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 8/19/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class CartViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkOutButton: UIButton!
    var receiveCart = [Cart]()
    var qty: Int = 1
    var cart = [Cart]()
    var selectRow: Int = 0
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveCart = loadCart()
        if receiveCart.count == 0 {
            self.checkOutButton.isHidden = true
            let alert = UIAlertController(title: "Notice", message: "The Cart is Empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { action in self.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiveCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cartListCell"
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?  CartTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CartTableViewCell.")
        }
        cell.increaseButton.addTarget(self, action:#selector(increaseButtonPressed(_:)), for:.touchUpInside)
        cell.decreaseButton.addTarget(self, action:#selector(decreaseButtonPressed(_:)), for:.touchUpInside)
        let myCart = receiveCart[indexPath.row]
        cell.quantityLabel.text = String(describing: myCart.qty!)
        cell.productTitle.text = myCart.title
        cell.productImage.image = myCart.photo
        cell.productDescription.text = (myCart.descriptionOfProduct)! + "..."
        cell.priceLabel.text = ("Price: \(String(describing: myCart.price!)) JD ")
        return cell
    }
    
    func increaseButtonPressed(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? UITableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        selectRow = (indexPath?.row)!
        receiveCart[selectRow].qty! += 1
        let updateindex = IndexPath(item: selectRow, section: 0)
        tableView.reloadRows(at: [updateindex], with: .none)
        saveCart()
    }
    
    func decreaseButtonPressed(_ sender: AnyObject) {
        let button = sender as? UIButton
        let cell = button?.superview?.superview as? UITableViewCell
        let indexPath = tableView.indexPath(for: cell!)
        selectRow = (indexPath?.row)!
        if receiveCart[selectRow].qty! > 1 {
            receiveCart[selectRow].qty! -= 1
        }else {
            receiveCart[selectRow].qty! = 1
        }
        
        let updateindex = IndexPath(item: selectRow, section: 0)
        tableView.reloadRows(at: [updateindex], with: .none)
        saveCart()
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
    
    func saveCart() {
        cart = receiveCart
        let cartData = NSKeyedArchiver.archivedData(withRootObject: cart)
        UserDefaults.standard.set(cartData, forKey: "cartData")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "", message: "Are you sure to delete?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { action in
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            } ))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.receiveCart.remove(at: indexPath.row)
        saveCart()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow = indexPath.row
    }
}
