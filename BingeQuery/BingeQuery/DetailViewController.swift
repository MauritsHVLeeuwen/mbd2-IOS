//
//  DetailViewController.swift
//  BingeQuery
//
//  Created by Maurits van Leeuwen on 28/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var selectedSeries: Series!
    @IBOutlet weak var TitelText: UILabel!
    @IBOutlet weak var SeasonText: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var DescriptionText: UILabel!
    
    override func viewDidLoad() {
        TitelText.text = selectedSeries._title
        SeasonText.text = "Seasons: \(selectedSeries._seasons)"
        ImageView.image = selectedSeries._image
        DescriptionText.text = selectedSeries._description
    }
}
