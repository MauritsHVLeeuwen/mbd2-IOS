//
//  ViewController.swift
//  BingeQuery
//
//  Created by Maurits van Leeuwen on 21/02/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

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
    
    @IBOutlet weak var EditButton: UIBarButtonItem!
    var filteredContent = [Series]()
    @IBOutlet weak var searchResult: UISearchBar!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchResult.delegate = self
        searchResult.returnKeyType = UIReturnKeyType.done
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredContent.count
        }
        
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table Entry", for: indexPath)
        
        let series: Series
        if isSearching {
            series = filteredContent[indexPath.row]
        } else {
            series = content[indexPath.row]
        }
        
        cell.textLabel?.text = series._title
        cell.detailTextLabel?.text = "Seasons: \(series._seasons)"
        cell.imageView?.image = series._image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = content[sourceIndexPath.row]
        content.remove(at: sourceIndexPath.row)
        content.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let store = segue.destination as? DetailViewController {
            store.selectedSeries = content[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    @IBAction func EditClick(_ sender: Any) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        if(self.tableView.isEditing) {
            EditButton.title = "Done"
        } else {
            EditButton.title = "Edit"
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchResult.text == nil || searchResult.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredContent = content.filter({( series : Series) -> Bool in
                return series._title.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    }
}

