#  Notes

## CardView
A CardView will have to be made with explicitly defined ratio and shapes inside. All of this only THEN can be resized to whatever i want. But first, create a card with a specific dimensions and the shapes inside conform their size to whatever card gives them. This all can then be transfered into GameSetView.

## My own implementation of gameplay. Erased and made conforming to assignment
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


## An attempt to a better match check solution
    if numberOfShapesMatching {
        if shapesMatching {
            if shadingMatching {
                if colorsMatching {
                    return true
                }
            }
        } else if shapesNotMatching {
            if shadingMatching {
                if colorsMatching {
                    return true
                }
            }
        }
    } else if numberOfShapesNotMatching {
        if shapesNotMatching {
            if shadingNotMatching {
                if colorsNotMatching {
                    return true
                }
            }
        } else if shapesMatching {
            
        }
    }


old match solution
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
