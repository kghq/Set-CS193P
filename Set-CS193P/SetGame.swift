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
    
    enum Selection {
        case free, chosen, matched
    }
    
    struct Card: Identifiable, Equatable {
        let numberOfShapes: Int // one, two, or three
        let shape: Int // diamond, squiggle, oval
        let shading: Int // solid, striped, or open
        let color: Int // red, green, or purple
        
        var selectionState = Selection.free
        let id = UUID()
    }
    
    var chosenCards = [Card]()
    
    mutating func choose(_ card: Card) {
        
        // getting the selected card
        if let chosenIndex = tableDeck.firstIndex(where: { $0.id == card.id } ) {
            
            selectACard(withIndex: chosenIndex)
            
            // making a temp deck of chosen cards
            var chosenCards: [Card] {
                return tableDeck.filter( { $0.selectionState == .chosen } )
            }
            
            // checking if we have a set from previous round
            var weHaveASet: Bool {
                return tableDeck.contains( where: { $0.selectionState == .matched } )
            }
            
            // what to do, when there is a match from previous round
            
            // check for a match with 3 cards
            if chosenCards.count == 3 {
                if setIsFound(in: chosenCards) {
                    score += 1
                    for index in tableDeck.indices {
                        if tableDeck[index].selectionState == .chosen {
                            tableDeck[index].selectionState = .matched
                        }
                    }
                }
            }
            
            // start new selection if no match with 3 cards
            if chosenCards.count == 4 || (chosenCards.count == 1 && weHaveASet) {
                if weHaveASet {
                    newRound()
                } else {
                    for index in 0..<tableDeck.count {
                        tableDeck[index].selectionState = .free
                    }
                    selectACard(withIndex: chosenIndex)
                }
            }
            
            // What to do, when set is found
            if chosenCards.count == 3 {
                if setIsFound(in: chosenCards) {
                    score += 1
                    for index in tableDeck.indices {
                        if tableDeck[index].selectionState == .chosen {
                            tableDeck[index].selectionState = .matched
                        }
                    }
                }
            }
        }
    }
    
    mutating func selectACard(withIndex chosenIndex: Int) {
        if tableDeck[chosenIndex].selectionState == .free {
            tableDeck[chosenIndex].selectionState = .chosen
        } else if tableDeck[chosenIndex].selectionState == .chosen {
            tableDeck[chosenIndex].selectionState = .free
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
    
    // what to do after set found (button to discard set and draw new cards)
    mutating func newRound() {
        tableDeck.removeAll(where: { $0.selectionState == .matched } )
        drawCard(amount: 3)
    }
    
    // make new game
    
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
