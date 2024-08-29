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
    
    private var model: SetGame
    
    var deck: [SetGame.Card] {
        return model.deck
    }
    
    static func createSetGame() -> SetGame {
        return SetGame()
    }
    
    func choose(_ card: SetGame.Card) {
        model.choose(card)
    }
}
