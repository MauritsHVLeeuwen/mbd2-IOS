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
    var types : [PokemonTypes]
    var sprites : PokemonSprites
}

struct PokemonTypes : Codable{
    var type : PokemonTypeName
}

struct PokemonTypeName : Codable{
    var name : String
}

struct PokemonSprites : Codable{
    var front_default : String
}
