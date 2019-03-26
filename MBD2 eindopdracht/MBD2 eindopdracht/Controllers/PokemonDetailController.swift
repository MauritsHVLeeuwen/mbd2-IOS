//
//  PokemonDetailController.swift
//  MBD2 eindopdracht
//
//  Created by Maurits van Leeuwen on 26/03/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation
import UIKit

class PokemonDetailController: UIViewController {
    
    var pokemonID: Int!
    var pokemonsCaught: Array<String>!
    var listController: PokemonListController!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var releaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emptyList : [String:Array<Int>] = ["nl.avans.pokemoncatcher.pokemons" : []]
        UserDefaults.standard.register(defaults: emptyList)
        pokemonsCaught = UserDefaults.standard.stringArray(forKey: "nl.avans.pokemoncatcher.pokemons")
        
        PokemonApi.sharedInstance.getPokemonDetail(pokemonNumber: pokemonID, callback: self.fillPokemonData)
    }
    
    func fillPokemonData(pokemonData: PokemonData) {
        nameLabel.text = pokemonData.name
        type1Label.text = pokemonData.types[0].type.name
        
        if(pokemonData.types.count > 1) {
            type2Label.text = pokemonData.types[1].type.name
        } else {
            type2Label.text = ""
        }
        
        if(pokemonsCaught.contains(String(pokemonData.id))) {
            statusLabel.text = "Status: Gevangen"
        } else {
            statusLabel.text = "status: Ongevangen"
            releaseButton.removeFromSuperview()
        }
        
        let url = URL(string: pokemonData.sprites.front_default)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                
                let image = UIImage(data: data!)!
                self.ImageView.image = image
            }
        }
    }
    
    @IBAction func releaseClicked(_ sender: Any) {
        pokemonsCaught = pokemonsCaught.filter { $0 != String(pokemonID) }
        UserDefaults().set(pokemonsCaught, forKey: "nl.avans.pokemoncatcher.pokemons")
        
        statusLabel.text = "status: Ongevangen"
        releaseButton.removeFromSuperview()
        listController.reload()
    }
    
}
