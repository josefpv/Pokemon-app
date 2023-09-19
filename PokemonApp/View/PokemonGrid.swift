//
//  PokemonGrid.swift
//  PokemonApp
//
//  Created by Jose Vivas on 28-07-23.
//

import SwiftUI

struct PokemonGrid: View {

    private let gridItemColumns = [GridItem(.flexible()), GridItem(.flexible())]

    //swift will observes this object and its changes, UI will be refeshed every time this object changes
    @ObservedObject var viewModel = PokemonViewModel()
    
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .green.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: gridItemColumns, spacing: 16) {
                        ForEach(viewModel.pokemon) {
                            pokemon in
                            NavigationLink {
                                PokemonDetailView(viewModel: viewModel, pokemon: pokemon)
                            } label: {
                                PokeCell(pokemon: pokemon, viewModel: viewModel)
                            }
                                
                        }
                    }
                }
            }
        }.navigationTitle("Pokemon \(viewModel.pokemon.count)")
    }
}

struct PokemonGrid_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGrid()
    }
}
