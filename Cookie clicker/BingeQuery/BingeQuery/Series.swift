//
//  Series.swift
//  BingeQuery
//
//  Created by Maurits van Leeuwen on 21/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class Series {
    
    var _title: String
    var _description: String
    var _seasons: Int
    var _image: UIImage
    
    init(title: String, description: String, seasons: Int, image: UIImage) {
        _title = title
        _description = description
        _seasons = seasons
        _image = image
    }
    
}
