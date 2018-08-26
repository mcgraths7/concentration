//
//  Card.swift
//  concentration
//
//  Created by Steven McGrath on 8/26/18.
//  Copyright © 2018 Steven McGrath. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactor = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactor += 1
        return identifierFactor
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // TODO: add a property "hasBeenSeen" to track whether the card has been seen
    
}
