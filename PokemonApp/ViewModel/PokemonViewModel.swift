//
//  PokemonViewModel.swift
//  PokemonApp
//
//  Created by Jose Vivas on 28-07-23.
//
import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject{
    
    @Published var pokemon = [Pokemon]()
    
    let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init() {
       fetchData()
    }
    
    func fetchData(){
        guard let url = URL(string: baseURL) else {
            //if it do not work
            return
        }
    
        URLSession.shared.dataTask(with: url){
            
            (data, response, error) in
            
            //the data values contains null (invalid) values so it needs to be deleted and converted to data type, for that we use extensions
            
            
            //more code here
            guard let data = data?.parseData(removeString: "null,") else {
                return
            }
            
           
            
            //converting/decode the data in the pokemon array model
            guard let pokemon = try? JSONDecoder().decode([Pokemon].self, from: data) else {
                return
            }
            
            print("heres data")
            print(pokemon)
            
            //store the data
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
            
            //resume the taks if its not running
        }.resume()
        
    
        
        
    }
    
    func backgroundColor(forType type: String) -> UIColor {
        switch type{
        case "fire": return .orange
        case "poison": return .purple
        case "water": return .blue
        case "electric": return .yellow
        case "phychic": return .brown
        case "normal": return .magenta
        case "ground": return .green
        case "flying": return .cyan
        case "fairy": return .systemTeal
        default: return .systemPink
        }
    }
}

extension Data{
    func parseData(removeString string: String) -> Data? {
        
        //Converting data value as string 'self' is what is calling the function
        let dataAsString = String(data: self, encoding: .utf8 )
        
        //search and replacing what 'string' (input) is inside de dataAsString
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        
        guard let data = parsedDataString?.data(using: .utf8) else {
            return nil
        }
   
        return data
    }
}
