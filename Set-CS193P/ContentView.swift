//
//  ContentView.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import SwiftUI

struct ContentView: View {
    let game = SetGame()
    
    var body: some View {
        table
    }
    
    private var table: some View {
        ForEach(game.deck) { card in
            CardView(card)
        }
    }
    
}

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        VStack {
            Text("\(card.numberOfShapes)")
            Text("\(card.shape)")
            Text("\(card.shading)")
            Text("\(card.color)")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(card.isChosen ? .blue : .gray, lineWidth: 3)
        )
//        .onTapGesture {
//            card.isChosen.toggle()
//        }
    }
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
}

#Preview {
    ContentView()
}
