//
//  ViewController.swift
//  Erabia Traning
//
//  Created by bahaa alrifai on 7/27/17.
//  Copyright © 2017 bahaa alrifai. All rights reserved.
//

import UIKit
import Crashlytics


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CheckOutViewControllerDelegate {
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var bannerTableView: UITableView!
    var products = [Product]()
    var banners = [Banner]()
    var numOfRow: Int = 0
    var productTuple = [(String, UIImage, Int64)]()
    var bannerTuple = [(UIImage, String)]()
    var cartView: CartViewController?
    @IBAction func forwardButton(_ sender: Any) {
       
            Crashlytics.sharedInstance().crash()
   
        
        if numOfRow >  0 {
            numOfRow -= 1
            backwardButton.isHidden = false
        } else {
            numOfRow = 0
            forwardButton.isHidden = true
        }
        if numOfRow ==  0  {
            numOfRow = 0
            forwardButton.isHidden = true
            backwardButton.isHidden = false
        }
        self.bannerTableView.reloadData()
    }
    
    @IBAction func backwardButton(_ sender: Any) {
        if numOfRow <  banners.count - 1   {
            numOfRow += 1
            forwardButton.isHidden = false
        } else {
            numOfRow = banners.count - 1
            backwardButton.isHidden = true
        }
        if numOfRow ==  banners.count - 1  {
            numOfRow = banners.count - 1
            backwardButton.isHidden = true
            forwardButton.isHidden = false
        }
        self.bannerTableView.reloadData()
    }
    
    private func loadBanner() {
        let bannerImage1 = UIImage(named: "acerAspire")
        let bannerImage2 = UIImage(named: "acerAspire14")
        let bannerImage3 = UIImage(named: "appleMacbook")
        let bannerImage4 = UIImage(named: "Tabpro")
        bannerTuple = [(bannerImage1!, "https://www.yahoo.com" ), (bannerImage2!, "https://www.google.com"), (bannerImage3!,"https://www.udemy.com"), (bannerImage4!,"https://www.google.com")]
        for  i in 0...bannerTuple.count - 1 {
            guard  let banner = Banner(bannerImage: bannerTuple[i].0, webpageAddress: bannerTuple[i].1) else{ fatalError("Unable to instantiate product1") }
            self.banners.append(banner)
        }
    }
    
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
        for  i in 0...productTuple.count - 1 {
            guard  let product = Product(title: productTuple[i].0, photo: productTuple[i].1, description: nil, price: productTuple[i].2) else{ fatalError("Unable to instantiate product1") }
            self.products.append(product)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView = CartViewController()
        cartView?.delegate = self
        loadSampleProducts()
        loadBanner()
        if numOfRow == 0 {
            backwardButton.isHidden = false
            forwardButton.isHidden = true
        } else {
            backwardButton.isHidden = true
            forwardButton.isHidden = false
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate
        bannerView.addGestureRecognizer(tap)
    }
    
    func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        if let webPage = banners[numOfRow].webpageAddress {
            let alert = UIAlertController(title: "Open Page...", message: "Would you like to open the webpage?", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {action in  self.open(scheme: webPage) }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
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
        if tableView.tag == 1 {
            return 1
        } else if tableView.tag == 2 {
            return products.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 2:
            let cellIdentifier = "productCell"
            let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductTableViewCell
            let product = products[indexPath.row]
            cell.titleLable.text = product.title
            cell.photoImageView.image = product.photo
            cell.priceLable.text = ("Price: \(String(describing: product.price!))JD ")
            return cell
        case 1:
            let cellIdentifier = "bannerCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as!BannerTableViewCell
            self.bannerTableView.beginUpdates()
            let banner = banners[numOfRow]
            cell.bannerImageView.image = banner.bannerImage
            self.bannerTableView.endUpdates()
            return cell
        default: break
        }
        return UITableViewCell()
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 2 {
            self.performSegue(withIdentifier: "goToListing", sender: nil)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func sayThanks(total: Int) {
        let alert = UIAlertController(title: "", message: "Thank you for your order,The total is \(total) JD, We will Contact you soon", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCart"{
            if let navigationController = segue.destination as? UINavigationController {
                let vc = navigationController.topViewController as! CartViewController
                vc.delegate = self
            }
}


}

}


