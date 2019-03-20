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
    @IBOutlet weak var cookieImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.addCookies), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func CookieClicked(_ sender: Any) {
        addAnimationLabel()
        cookieAnimation()
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
    
    func addAnimationLabel() {
        let locationX = cookieImage.center.x + CGFloat(arc4random() % UInt32(cookieImage.bounds.width)) - cookieImage.bounds.width/4
        let locationY = cookieImage.center.x + CGFloat(arc4random() % UInt32(cookieImage.bounds.width)) - cookieImage.bounds.width/4
        
        let animatedLabel = UILabel(frame: CGRect(x: 0, y:0, width:200, height: 40))
        animatedLabel.text = "Cookie +1"
        
        animatedLabel.center = CGPoint(x: locationX, y: locationY)
        
        self.view.addSubview(animatedLabel)
        
        UIView.animate(withDuration: 2.0,
                       animations: {
                                        animatedLabel.frame.origin.y -= 100.0
                                        animatedLabel.alpha = 0.0 },
                       completion: { finished in
                                        animatedLabel.removeFromSuperview()
        })
    }
    
    func cookieAnimation() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: [.allowUserInteraction],
            animations: {self.cookieImage.transform = CGAffineTransform.init(scaleX: 1.025, y: 1.025) },
            completion: {finished in
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0,
                    usingSpringWithDamping: 0.1,
                    initialSpringVelocity: -1.0,
                    options: [ .allowUserInteraction ],
                    animations: { self.cookieImage.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0) },
                    completion: { finished in }
                )
            }
        )
    }
}

