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
//        Button("Add") {
//            game.drawCard(amount: 1)
//        }
        table
    }
    
    private var table: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(game.tableDeck) { card in
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
        HStack {
            Text("\(card.numberOfShapes)")
            Text("\(card.shape)")
            Text("\(card.shading)")
            Text("\(card.color)")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(card.isChosen ? .blue : .yellow, lineWidth: 3)
        )
    }
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
}

#Preview {
    ContentView()
}
