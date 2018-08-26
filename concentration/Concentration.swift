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
        
    }
}
