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
    
    struct Card: Identifiable {
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
                    var setFound = false
                    
                    // round of checks for set
                    // there is set if:
                    // card[0]
                    
                    if setFound {
                        // remove set cards from table and draw next
                        tableDeck.removeAll(where: { $0.isChosen == true })
                        drawCard(amount: 3)
                        chosenCards.removeAll()
                    } else {
                        for index in 0...tableDeck.count - 1 {
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
    
    func setChecker(_ cards: [Card]) -> Bool {
        for index in 0...cards.count {
            
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
        
        for numberOfShapes in 1...3 {
            for shape in 1...3 {
                for shading in 1...3 {
                    for color in 1...3 {
                        //let id = numberOfShapes * 1000 + shape * 100 + shading * 10 + color
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
