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
    
    var cookiesClicked = 0
    var viewController = 0
    
    override func viewDidLoad() {
        CookiesLabel.text = "\(cookiesClicked) cookies"
    }
    
}
