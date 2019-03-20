//
//  PokemonApi.swift
//  MBD2 eindopdracht
//
//  Created by Maurits van Leeuwen on 20/03/2019.
//  Copyright © 2019 Maurits van Leeuwen. All rights reserved.
//

import Foundation

public class PokemonApi {
    
    static let sharedInstance = PokemonApi()
    
    var pokemonList = [SmallPokemonData]()
    
    fileprivate init() {
        //get pokemon data
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=151") {
            let task = URLSession.shared.dataTask(with: url) {data, response, error in
                do {
                    let decoder = JSONDecoder()
                    let pokemonData = try decoder.decode(PokemonListData.self, from: data!)
                    self.pokemonList = pokemonData.results
                } catch let jsonErr {
                    print("Failed", jsonErr)
                }
            }
            task.resume()
        }
    }
    
    func getPokemon() -> [SmallPokemonData] {
        return pokemonList
    }
    
    func getPokemonDetail(pokemonNumber: Int, callback: @escaping (PokemonData)->()) {
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonNumber)") {
            let task = URLSession.shared.dataTask(with: url) {data, response, error in
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(PokemonData.self, from: data!)
                    callback(data)
                } catch let jsonErr {
                    print("Failed", jsonErr)
                }
            }
            task.resume()
        }
    }
    
}
