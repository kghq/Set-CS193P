//
//  SetGame.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import Foundation

struct SetGame {
    private(set) var deck: [Card]
    private(set) var tableDeck: [Card]
    private(set) var score: Int
    
    struct Card: Identifiable, Equatable {
        let numberOfShapes: Int // one, two, or three
        let shape: Int // diamond, squiggle, oval
        let shading: Int // solid, striped, or open
        let color: Int // red, green, or purple
        
        var isChosen = false // blue/gray stroke when chosen/unchosen
        let id = UUID()
    }
    
    var chosenCards = [Card]()
    
    mutating func choose(_ card: Card) {
        
        if let chosenIndex = tableDeck.firstIndex(where: { $0.id == card.id } ) {
            
            // what to do when card is chosen: if there is 3 now, check for set
            if tableDeck[chosenIndex].isChosen == false {
                
                // setting to highlight choice
                tableDeck[chosenIndex].isChosen = true
                
                // adding cards to potential check
                if chosenCards.count < 3 {
                    chosenCards.append(tableDeck[chosenIndex])
                    print(chosenCards.count)
                }
                
                // checking for set and resetting the round
                if chosenCards.count == 3 {
                    
                    // if set found: add point, remove set cards from table and draw next
                    if setIsFound(in: chosenCards) {
                        score += 1
                        tableDeck.removeAll(where: { $0.isChosen == true })
                        // adds so many cards as to be back with 12
                        if tableDeck.count < 12 {
                            drawCard(amount: 12 - tableDeck.count)
                        }
                        //drawCard(amount: 3)
                        chosenCards.removeAll()
                    // if set not found: clear chosenCards and turn off highlight
                    } else {
                        for index in 0..<tableDeck.count {
                            tableDeck[index].isChosen = false
                        }
                        chosenCards.removeAll()
                    }
                }
                
                
                
            // what to do when card is unchosen
            } else {
                // toggle highlight
                tableDeck[chosenIndex].isChosen = false
                
                // remove from chosencards
                chosenCards.removeAll(where: { $0.id == tableDeck[chosenIndex].id } )
                print(chosenCards.count)
            }
        }
    }
    
    // round of checks for set
    // implementation leaves much to be desired
    func setIsFound(in cards: [Card]) -> Bool {
        // those checks are far from elegant
        // match
        let numberOfShapesMatching = (cards[0].numberOfShapes == cards[1].numberOfShapes) && (cards[0].numberOfShapes == cards[2].numberOfShapes)
        let shapesMatching = (cards[0].shape == cards[1].shape) && (cards[0].shape == cards[2].shape)
        let shadingMatching = (cards[0].shading == cards[1].shading) && (cards[0].shading == cards[2].shading)
        let colorsMatching = (cards[0].color == cards[1].color) && (cards[0].color == cards[2].color)
        // not match
        let numberOfShapesNotMatching = (cards[0].numberOfShapes != cards[1].numberOfShapes) && (cards[1].numberOfShapes != cards[2].numberOfShapes) && (cards[0].numberOfShapes != cards[2].numberOfShapes)
        let shapesNotMatching = (cards[0].shape != cards[1].shape) && (cards[1].shape != cards[2].shape) && (cards[0].shape != cards[2].shape)
        let shadingNotMatching = (cards[0].shading != cards[1].shading) && (cards[1].shading != cards[2].shading) && (cards[0].shading != cards[2].shading)
        let colorsNotMatching = (cards[0].color != cards[1].color) && (cards[1].color != cards[2].color) && (cards[0].color != cards[2].color)
        
        // set found if one of those:
        if numberOfShapesNotMatching && shapesNotMatching && shadingNotMatching && colorsNotMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesMatching && shadingNotMatching && colorsNotMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesMatching && shadingNotMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesMatching && shadingMatching && colorsNotMatching {
            return true
        }
        
        if numberOfShapesNotMatching && shapesNotMatching && shadingNotMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesNotMatching && shapesNotMatching && shadingMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesNotMatching && shapesMatching && shadingMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesNotMatching && shadingNotMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesNotMatching && shadingNotMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesNotMatching && shadingMatching && colorsMatching {
            return true
        }
        
        if numberOfShapesMatching && shapesMatching && shadingMatching && colorsMatching {
            return true
        }
        
        return false
    }
    
    // draw card from Deck to table
    mutating func drawCard(amount: Int) {
        for _ in 1...amount {
            if deck.count > 0 {
                tableDeck.append(deck[0])
                deck.remove(at: 0)
            }
        }
    }
    
    // init creates a full deck of cards, shuffled. It populates cards with abstract Ints, rather than concrete features
    init() {
        deck = []
        tableDeck = []
        score = 0
        
        for numberOfShapes in 1...3 {
            for shape in 0...2 {
                for shading in 0...2 {
                    for color in 0...2 {
                        let newCard = Card(numberOfShapes: numberOfShapes, shape: shape, shading: shading, color: color)
                        deck.append(newCard)
                    }
                }
            }
        }
        
        deck.shuffle()
        drawCard(amount: 12)
    }
    // func for checking if three chosen cards make a set. What then?
    // add chosen card to an array
    // if array = 3: no more adding, check if this makes a set. Remove if set found, add points. Add new cards. Reset if no set.
    // extra: color for the chosen, other color if 3 and set.
    
    // func to deal first 12 cards, and replace the discarded ones, or a single one when requested
    
    // Will have to do something like "Cards on table", an array of cards on the table. Initially 12, but can change (when drawing an extra card, or when Deck is drying up)
    // what to do when card is chosen: toggle highlight, append to chosenCards, if there is 3 now, check for set
    // add some kind of scoring or at least notification for found set
}
