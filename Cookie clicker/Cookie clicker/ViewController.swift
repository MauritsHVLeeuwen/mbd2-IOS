//
//  ViewController.swift
//  Cookie clicker
//
//  Created by Maurits van Leeuwen on 21/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    var timesClicked = 0
    var grandmas = 0
    var farms = 0
    
    @IBOutlet weak var ClicksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var AddCookiesTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.addCookies), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func CookieClicked(_ sender: Any) {
        timesClicked += 1
        ClicksLabel.text = "\(timesClicked) times."
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let store = segue.destination as? StoreController {
            store.viewController = self
        }
    }
    
    public func UpdateCookies() {
        ClicksLabel.text = "\(timesClicked) times."
    }
    
    @objc func addCookies()
    {
        timesClicked += grandmas * 1
        timesClicked += farms * 1
        UpdateCookies()
    }
}

