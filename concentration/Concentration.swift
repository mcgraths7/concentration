//
//  Concentration.swift
//  concentration
//
//  Created by Steven McGrath on 8/26/18.
//  Copyright © 2018 Steven McGrath. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUp: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var flipCount = 0
    var score = 0
    
    init(numOfPairsOfCards: Int) {
        assert(numOfPairsOfCards > 0, "Concentration.init(\(numOfPairsOfCards)): you must have at least one pair of cards")
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
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in the cards")
        if !cards[index].hasBeenSeenOnce {
            cards[index].hasBeenSeenOnce = true
        } else {
            cards[index].hasBeenSeenMultipleTimes = true
        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                } else if cards[matchIndex] != cards[index] {
                    if cards[index].hasBeenSeenMultipleTimes && cards[matchIndex].hasBeenSeenMultipleTimes {
                        score -= 2
                    } else if (!cards[index].hasBeenSeenMultipleTimes && cards[matchIndex].hasBeenSeenMultipleTimes) ||
                        (!cards[matchIndex].hasBeenSeenMultipleTimes && cards[index].hasBeenSeenMultipleTimes) {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUp = index
            }
        }
        flipCount += 1
    }
    
    mutating func resetFlipCount() {
        flipCount = 0
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first: nil
    }
}
