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
        Button("Add") {
            game.drawCard(amount: 1)
        }
        table
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: game.deck)
        Text("Score: \(game.score)")
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
    
    var shading: Double {
        if card.shading == 0 {
            return 0
        } else if card.shading == 1 {
            return 0.5
        } else {
            return 1
        }
    }

    var color: Color {
        if card.color == 0 {
            return .red
        } else if card.color == 1 {
            return .green
        } else {
            return .purple
        }
    }
    
    var body: some View {
        VStack {
            ForEach(0..<card.numberOfShapes, id: \.self) { _ in
                if card.shape == 0 {
                    Rectangle()
                        .strokeBorder(color, lineWidth: 3)
                        .fill(color.opacity(shading))
                        .frame(width: 30, height: 30)
                } else if card.shape == 1 {
                    Circle()
                        .strokeBorder(color, lineWidth: 3)
                        .fill(color.opacity(shading))
                        .frame(width: 30, height: 30)
                } else {
                    Rectangle()
                        .strokeBorder(color, lineWidth: 3)
                        .fill(color.opacity(shading))
                        .frame(width: 20, height: 40)
                        .rotationEffect(.degrees(45))
                }
            }
//            Text("\(card.numberOfShapes)")
//            Text("\(card.shading)")
//            Text("\(card.color)")
        }
        .frame(width: 70, height: 120)
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
