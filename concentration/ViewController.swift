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
    
    var emojiChoices = ["🎃", "🎃", "👻", "👻", "🦇", "🦇"]
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Chosen card not in cardButtons")
        }
        
    }
    
    
    func flipCard(withEmoji emoji: String, on  button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = UIColor.orange
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = UIColor.white
        }
    }
    


}

