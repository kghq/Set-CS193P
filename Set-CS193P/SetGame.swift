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
        
        var isChosen = false // blue/gray stroke when chosen/unchosen
        let id = UUID()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = deck.firstIndex(where: { $0.id == card.id } ) {
            deck[chosenIndex].isChosen = true
        }
    }
    
    // init creates a full deck of cards, shuffled. It populates cards with abstract Ints, rather than concrete features
    init() {
        deck = []
        
        for numberOfShapes in 1...2 {
            for shape in 1...2 {
                for shading in 1...2 {
                    for color in 1...2 {
                        //let id = numberOfShapes * 1000 + shape * 100 + shading * 10 + color
                        let newCard = Card(numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color)
                        deck.append(newCard)
                    }
                }
            }
        }
        
        //deck.shuffle()
    }
    // func for checking if three chosen cards make a set. What then?
    // add chosen card to an array
    // if array = 3: no more adding, check if this makes a set. Remove if set found, add points. Add new cards. Reset if no set.
    // extra: color for the chosen, other color if 3 and set.
    
    // func to deal first 12 cards, and replace the discarded ones, or a single one when requested
}
