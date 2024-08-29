//
//  SetGame.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import Foundation

struct SetGame {
    private(set) var deck: [Card]
    
    struct Card: Identifiable {
        let numberOfShapes: Int // one, two, or three
        let shape: Int // diamond, squiggle, oval
        let shading: Int // solid, striped, or open
        let color: Int // red, green, or purple
        
        var isChosen = false // blue stroke
        let id: Int
    }
    
    // init creates a full deck of cards, shuffled. It populates cards with abstract Ints, rather than concrete features
    init() {
        deck = []
        
        for numberOfShapes in 1...3 {
            for shape in 1...3 {
                for shading in 1...3 {
                    for color in 1...3 {
                        let id = numberOfShapes * 1000 + shape * 100 + shading * 10 + color
                        let newCard = Card(numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color, id: id)
                        deck.append(newCard)
                    }
                }
            }
        }
        
        deck.shuffle()
    }
    // func for checking if three chosen cards make a set. What then?
    // func to deal first 12 cards, and replace the discarded ones, or a single one when requested
}
