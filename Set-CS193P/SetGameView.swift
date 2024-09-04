//
//  ContentView.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import Observation
import SwiftUI

struct SetGameView: View {
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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize))]) {
                ForEach(game.tableDeck) { card in
                    CardView(card)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height - 300 {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

#Preview {
    SetGameView()
}
