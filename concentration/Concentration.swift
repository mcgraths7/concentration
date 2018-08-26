//
//  Concentration.swift
//  concentration
//
//  Created by Steven McGrath on 8/26/18.
//  Copyright © 2018 Steven McGrath. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUp: Int?
    
    init(numOfPairsOfCards: Int) {
        for _ in 1...numOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        var shuffled = [Card]()
        for _ in 1...cards.count {
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            shuffled.append(cards[rand])
            cards.remove(at: rand)
        }
        cards = shuffled
    }
    
    // Take array of cards
    // check their identifier
    // "ramndomly" reorganize the cards

    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = index
            }
        }
    }
}
