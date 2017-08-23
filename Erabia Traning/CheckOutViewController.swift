//
//  CheckOutViewController.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 8/19/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalTextField: UITextField!
    var receiveCart = [Cart]()
    var cart = [Cart]()
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pleaseOrderButton(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        receiveCart.removeAll()
        saveCart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveCart = loadCart()
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
        let cellIdentifier = "checkOutListCell"
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?  CheckOutTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CartTableViewCell.")
        }
        let myCart = receiveCart[indexPath.row]
        cell.qtyTextFiled.text = String(describing: myCart.qty!)
        cell.productTitle.text = myCart.title
        cell.productImage.image = myCart.photo
        cell.productDescription.text = (myCart.descriptionOfProduct)! + "..."
        cell.qtyTextFiled.text = String(myCart.qty!)
        cell.priceTextField.text = ("\(String(describing: Int(myCart.price!) * myCart.qty!)) JD ")
        return cell
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
    
    override func viewDidAppear(_ animated: Bool) {
        total = calculateTotalCost()
        totalTextField.text = String("\(total) JD")
    }
    
    func calculateTotalCost() -> Int{
        for i in 0...receiveCart.count - 1   {
            total +=  (Int(receiveCart[i].price!) * receiveCart[i].qty!)
        }
        return total
    }
    
    func saveCart() {
        cart = receiveCart
        let cartData = NSKeyedArchiver.archivedData(withRootObject: cart)
        UserDefaults.standard.set(cartData, forKey: "cartData")
    }
}
