//
//  ViewController.swift
//  AlwaysNote
//
//  Created by Maurits van Leeuwen on 28/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    var fontsize: Double = 0
    
    @IBAction func saveClicked(_ sender: Any) {
        do {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let name = "note.txt"
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(name)
            
            let noteContents = textview.text
            try noteContents?.write(to: fileURL, atomically: true, encoding: String.Encoding.unicode)
            
            let alert = UIAlertController(
                title: "AlwaysNote",
                message: "Uw text is opgeslagen",
                preferredStyle: .actionSheet)
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            alert.addAction(UIAlertAction(title: "ok, thanks", style: .default))
            
            self.present(alert, animated: true)
        } catch { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
        do {
            
            let name = "note.txt"
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(name)
            let text = try String(contentsOf: fileURL, encoding: .unicode)
            textview.text = text
            
        } catch {}
        
        let defaultUserDefaultValues : [String:Any] = ["nl.avans.alwaysnote.fontsize" : 17.0]
        UserDefaults.standard.register(defaults: defaultUserDefaultValues)
        
        fontsize = UserDefaults.standard.double(forKey: "nl.avans.alwaysnote.fontsize")
            
        textview.font = UIFont(name: textview.font!.fontName, size: CGFloat(fontsize))
    }
    
    @IBAction func decreaseFont(_ sender: Any) {
        fontsize -= 1
        textview.font = UIFont(name: textview.font!.fontName, size: CGFloat(fontsize))
        
        UserDefaults().set(fontsize, forKey: "nl.avans.alwaysnote.fontsize")
    }
    
    @IBAction func increaseFont(_ sender: Any) {
        fontsize += 1
        textview.font = UIFont(name: textview.font!.fontName, size: CGFloat(fontsize))
        
        UserDefaults().set(fontsize, forKey: "nl.avans.alwaysnote.fontsize")
    }
    

}

