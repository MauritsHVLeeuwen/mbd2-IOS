//
//  ViewController.swift
//  Cookie clicker
//
//  Created by Maurits van Leeuwen on 21/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timesClicked = 0
    @IBOutlet weak var ClicksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func CookieClicked(_ sender: Any) {
        timesClicked += 1
        ClicksLabel.text = "\(timesClicked) times."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let store = segue.destination as? StoreController {
            store.cookiesClicked = timesClicked
            store.viewController = this
        }
    }
    
}

