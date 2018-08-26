//
//  ViewController.swift
//  concentration
//
//  Created by Steven McGrath on 8/26/18.
//  Copyright © 2018 Steven McGrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numOfPairsOfCards: (cardButtons.count  + 1) /  2)
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    var emojiChoices = ["🦇", "🎃", "👻", "🐈", "🙀", "☠️", "🍬", "😈", "🍏", "🍭"]
    var emojiDict = Dictionary<Int, String>()
    var points = 0
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not in cardButtons")
        }
        
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = Concentration(numOfPairsOfCards: cardButtons.count / 2)
        flipCount = 0
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    

    
    func emoji(for card: Card) -> String {
        if emojiDict[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emojiDict[card.identifier] = emojiChoices.remove(at: randomIndex)
        }

        return emojiDict[card.identifier] ?? "?"
    }

}

