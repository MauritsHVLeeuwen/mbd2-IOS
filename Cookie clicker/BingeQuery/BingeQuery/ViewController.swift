//
//  ViewController.swift
//  BingeQuery
//
//  Created by Maurits van Leeuwen on 21/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var content = [
        Series(title: "Rick and Morty",
               description: "An animated series that follows the exploits of a super scientist and his not so bright grandson",
               seasons: 2,
               image: UIImage(named: "rickandmorty")!),
        
        Series(title: "Archer",
               description: "Covert black ops and espionage take a back seat to zany personalities and relationships between secret agents and drones.",
               seasons: 7,
               image: UIImage(named: "archer")!),
        
        
        Series(title: "House of Cards",
               description: "A Congressman works with his equally conniving wife to exact revenge on the people who betrayed him.",
               seasons: 4,
               image: UIImage(named: "houseofcards")!),
        
        Series(title: "Breaking Bad",
               description: "A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine in order to secure his family's future.",
               seasons: 5,
               image: UIImage(named: "breakingbad")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table Entry", for: indexPath)
        
        cell.textLabel?.text = content[indexPath.row]._title
        
        return cell
    }

}

