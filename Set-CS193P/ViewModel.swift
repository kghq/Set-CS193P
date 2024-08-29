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
    
    var deck: [SetGame.Card] {
        return model.deck
    }
    
    var tableDeck: [SetGame.Card] {
        return model.tableDeck
    }
    
    func choose(_ card: SetGame.Card) {
        model.choose(card)
    }
    
    func drawCard(amount: Int) {
        model.drawCard(amount: amount)
    }
}
