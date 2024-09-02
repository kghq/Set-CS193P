//
//  ContentView.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import Observation
import SwiftUI

struct GameSetView: View {
    var game = ViewModel()
    
    var body: some View {
        table
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: game.deck)
            .padding()
        Text("Score: \(game.score)")
        Button("Deal 3 More Cards") {
            game.addCards()
        }
        .disabled(game.deck.isEmpty)
        Button("New Game") {
            game.newGame()
        }
    }
    
    private var table: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(count: game.tableDeck.count, size: geometry.size, atAspectRatio: 2/3)
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: gridItemSize), spacing: 0)
            
            ], spacing: 0) {
                ForEach(game.tableDeck) { card in
                    CardView(card)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
    }
    
    func gridItemWidthThatFits( count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        return 95
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
    
    // selection highlight
    var selectionHighlight: Color {
        switch card.selectionState {
            case .free:
                return .yellow
            case .chosen:
                return .blue
            case .matched:
                return .orange
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(3/4, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(selectionHighlight, lineWidth: 3)
        )
    }
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
}

#Preview {
    GameSetView()
}
