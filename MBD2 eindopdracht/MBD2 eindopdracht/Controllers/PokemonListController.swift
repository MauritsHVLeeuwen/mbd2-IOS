//
//  PokemonListController.swift
//  MBD2 eindopdracht
//
//  Created by Maurits van Leeuwen on 20/03/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import UIKit

class PokemonListController: UITableViewController, UISearchBarDelegate {
    
    var filteredContent = [SmallPokemonData]()
    @IBOutlet weak var searchResult: UISearchBar!
    var isSearching = false
    var pokemonsCaught: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchResult.delegate = self
        searchResult.returnKeyType = UIReturnKeyType.done
        
        
        let emptyList : [String:Array<Int>] = ["nl.avans.pokemoncatcher.pokemons" : []]
        UserDefaults.standard.register(defaults: emptyList)
        pokemonsCaught = UserDefaults.standard.stringArray(forKey: "nl.avans.pokemoncatcher.pokemons")
        //initialize the pokemon Api
    }
    	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredContent.count
        }
        
        return PokemonApi.sharedInstance.getPokemon().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon: SmallPokemonData
        if isSearching {
            pokemon = filteredContent[indexPath.row]
        } else {
            pokemon = PokemonApi.sharedInstance.getPokemon()[indexPath.row]
        }
    
        cell.textLabel?.text = pokemon.name
        
        let splitted = pokemon.url.components(separatedBy: "/")
        let id = splitted[splitted.count - 2]
        
        if(pokemonsCaught.contains(id)) {
            cell.detailTextLabel?.text = "Gevangen!"
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemonDetail = segue.destination as? PokemonDetailController {
            
            let pokemon: SmallPokemonData
            if(isSearching) {
                pokemon = filteredContent[self.tableView.indexPathForSelectedRow!.row]
            } else  {
                pokemon = PokemonApi.sharedInstance.getPokemon()[self.tableView.indexPathForSelectedRow!.row]
            }
            let splitted = pokemon.url.components(separatedBy: "/")
            
            pokemonDetail.pokemonID = Int(splitted[splitted.count - 2])
            pokemonDetail.listController = self
        }
    }

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
    
    func reload() {
        pokemonsCaught = UserDefaults.standard.stringArray(forKey: "nl.avans.pokemoncatcher.pokemons")
        tableView.reloadData()
    }
}



