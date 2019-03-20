//
//  PokemonListController.swift
//  MBD2 eindopdracht
//
//  Created by Maurits van Leeuwen on 20/03/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class PokemonListController: UITableViewController, UISearchBarDelegate {
    
    //@IBOutlet weak var EditButton: UIBarButtonItem!
    var filteredContent = [SmallPokemonData]()
    @IBOutlet weak var searchResult: UISearchBar!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchResult.delegate = self
        searchResult.returnKeyType = UIReturnKeyType.done
        
        //initialize the pokemon Api
        PokemonApi.sharedInstance
    }
    	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredContent.count
        }
        
        return PokemonApi.sharedInstance.getPokemon().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let series: SmallPokemonData
        if isSearching {
            series = filteredContent[indexPath.row]
        } else {
            series = PokemonApi.sharedInstance.getPokemon()[indexPath.row]
        }
    
        cell.textLabel?.text = series.name
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let store = segue.destination as? DetailViewController {
//            store.selectedSeries = content[self.tableView.indexPathForSelectedRow!.row]
//        }
//    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchResult.text == nil || searchResult.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredContent = PokemonApi.sharedInstance.getPokemon().filter({( series : SmallPokemonData) -> Bool in
                return series.name.lowercased().contains(searchText.lowercased())
            })
            tableView.reloadData()
        }
    }
}



