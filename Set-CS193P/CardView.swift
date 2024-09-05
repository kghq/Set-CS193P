//
//  CardView.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 04/09/2024.
//

import SwiftUI

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
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(selectionHighlight, lineWidth: 3)
                    .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                VStack {
                    ForEach(0..<card.numberOfShapes, id: \.self) { _ in
                        if card.shape == 0 {
                            Rectangle()
                                .strokeBorder(color, lineWidth: 3)
                                .fill(color.opacity(shading))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3)
                        } else if card.shape == 1 {
                            Circle()
                                .strokeBorder(color, lineWidth: 3)
                                .fill(color.opacity(shading))
                                .frame(width: geometry.size.width * 0.3)
                        } else {
                            Diamond()
                                .stroke(color, lineWidth: 3)
                                .fill(color.opacity(shading))
                                //.aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                        }
                    }
                }
                .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .padding(5)
    }
    
    init(_ card: SetGame.Card) {
        self.card = card
    }
}

#Preview {
    let game = ViewModel()
    
    return CardView(game.tableDeck[0])
}
