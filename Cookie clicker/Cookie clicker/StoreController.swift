//
//  StoreController.swift
//  Cookie clicker
//
//  Created by Maurits van Leeuwen on 21/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class StoreController: UIViewController {
    
    @IBOutlet weak var CookiesLabel: UILabel!
    
    var viewController: ViewController!
    
    override func viewDidLoad() {
        updateAmount()
        var AddCookiesTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(StoreController.updateAmount), userInfo: nil, repeats: true)
    }
    
    @IBAction func purchaseGrandma(_ sender: Any) {
        if viewController.timesClicked >= 10 {
            viewController.timesClicked -= 10
            viewController.grandmas += 1
            updateAmount()
        }
    }
    
    @IBAction func purchaseFarm(_ sender: Any) {
        if viewController.timesClicked >= 100 {
            viewController.timesClicked -= 100
            viewController.farms += 1
            updateAmount()
            
        }
    }
    
    @objc private func updateAmount() {
        viewController.UpdateCookies()
        CookiesLabel.text = "\(viewController.timesClicked) cookies"
    }
}
