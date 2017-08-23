//
//  ProductListingTableViewController.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/30/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit

class ProductListingTableViewController: UITableViewController {
    var didSelectRow: Int = 0
    var products = [Product]()
    var productTuple = [(String, UIImage,Int64)]()
    private func loadSampleProducts() {
        let photo1 = UIImage(named: "acerAspire")
        let photo2 = UIImage(named: "acerAspire14")
        let photo3 = UIImage(named: "appleMacbook")
        let photo4 = UIImage(named: "dellXps")
        let photo5 = UIImage(named: "hpElitebook")
        let photo6 = UIImage(named: "ipadAir3")
        let photo7 = UIImage(named: "lenovoThinkpad")
        let photo8 = UIImage(named: "lgGram")
        let photo9 = UIImage(named: "msi")
        let photo10 = UIImage(named: "Tabpro")
        productTuple = [("Acer Aspire",photo1!, 300), ("Acer Aspire 14",photo2!, 280), ("Apple Macbook",photo3!, 1800),("Dell Xps",photo4!, 450), ("HP Elitebook",photo5!, 370), ("Ipad Air3",photo6!, 410),("Lenovo Thinkpad",photo7!, 620), ("LG Gram",photo8!, 310), ("MSI",photo9!, 270),("Tab pro",photo10!, 308)   ]
        let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        for  i in 0...productTuple.count - 1 {
            guard  let product = Product(title: productTuple[i].0, photo: productTuple[i].1, description: description , price: productTuple[i].2) else{ fatalError("Unable to instantiate product") }
        self.products.append(product)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleProducts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "productListCell"
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?  ProductListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProductTableViewCell.")
        }
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.photoImageView.image = product.photo
        cell.priceLabel.text = ("Price: \(String(describing: product.price!)) JD ")
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectRow = indexPath.row
        self.performSegue(withIdentifier: "goToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let sending = segue.destination as! DetailViewController
        var selectTitle: String?
        var selectPhoto: UIImage?
        var selectDecription: String?
        var selectPrice: Int64?
        selectTitle = products[didSelectRow].title
        selectPhoto = products[didSelectRow].photo
        selectDecription = products[didSelectRow].description
        selectPrice = products[didSelectRow].price
        if let text = selectTitle {
            sending.text  = text
        }
        if let image = selectPhoto {
            sending.image  = image
        }
        if let decriptionText = selectDecription {
            sending.descriptin = decriptionText
        }
        
        if let price = selectPrice {
            sending.price = price
        }
    }
}
