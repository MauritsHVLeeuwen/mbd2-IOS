import Foundation


struct PokemonListData : Codable {
    var count : Int
    var results : [SmallPokemonData]
    var next : String?
    var previous : String?
}


struct SmallPokemonData : Codable{
    var name : String
    var url : String
}

struct PokemonData : Codable{
    var id : Int
    var name : String
    var Types : [PokemonTypes]
}

struct PokemonTypes : Codable{
    var name: String
}
