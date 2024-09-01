//
//  ViewModel.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 29/08/2024.
//

import Observation
import SwiftUI

@Observable
class ViewModel {
    
    init() {
        model = ViewModel.createSetGame()
    }
    
    static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    private var model: SetGame
    
    // MARK: Game Components
    
    var deck: [SetGame.Card] {
        return model.deck
    }
    
    var tableDeck: [SetGame.Card] {
        return model.tableDeck
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: intents
    
    func choose(_ card: SetGame.Card) {
        model.choose(card)
    }
    
    func addCards() {
        model.newRound()
    }
    
    func newGame() {
        model = ViewModel.createSetGame()
    }
}

// test commit 2
