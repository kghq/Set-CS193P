//
//  ContentView.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import Observation
import SwiftUI

struct ContentView: View {
    var game = ViewModel()
    
    var body: some View {
        table
    }
    
    private var table: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(game.deck) { card in
                    CardView(card)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
    }
    
}

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        VStack {
            HStack {
                Text("\(card.numberOfShapes)")
                Text("\(card.shape)")
                Text("\(card.shading)")
                Text("\(card.color)")
            }
            Text("\(card.isChosen)")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(card.isChosen ? .blue : .yellow, lineWidth: 3)
        )
    }
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
}

#Preview {
    ContentView()
}
