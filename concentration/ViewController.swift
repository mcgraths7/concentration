//
//  ViewController.swift
//  concentration
//
//  Created by Steven McGrath on 8/26/18.
//  Copyright © 2018 Steven McGrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        themeIndex = pickRandomTheme()
    }
    
    lazy var game = Concentration(numOfPairsOfCards: (cardButtons.count  + 1) /  2)
    // MARK: this is a test
    var themeIndex: Int = 0
    var emojiDict = Dictionary<Int, String>()
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not in cardButtons")
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = Concentration(numOfPairsOfCards: cardButtons.count / 2)
        themeIndex = pickRandomTheme()
        game.flipCount = 0
        updateViewFromModel()
    }
    
    // MARK: Helper functions
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card, withTheme: themeIndex), for: UIControlState.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card, withTheme index: Int) -> String {
        if emojiDict[card.identifier] == nil, emojiThemesDict.count > 0 {
            
            for key in emojiThemesDict.keys {
                if key == index {
                    if var currentTheme = emojiThemesDict[key] {
                        let randomIndex = Int(arc4random_uniform(UInt32(currentTheme.count)))
                        emojiDict[card.identifier] = currentTheme.remove(at: randomIndex)
                        emojiThemesDict[key] = currentTheme
                    }
                }
            }
        }
        
        return emojiDict[card.identifier] ?? "?"
    }
    
    func pickRandomTheme() -> Int {
        return Int(arc4random_uniform(UInt32(emojiThemesDict.keys.count)))
    }
    
    // MARK: Available Themes
    var emojiThemesDict = [
        0 : ["😀", "🙂", "🤪", "🤩", "😤", "😱", "😐", "🤠"],
        1 : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        2 : ["🍏", "🍐", "🍌", "🍉", "🍇", "🍒", "🥥", "🌶"],
        3 : ["⛸", "☕️", "❄️", "☃️", "🧤", "🧦", "🧣", "🛷"],
        4 : ["🌂", "🌈", "☔️", "🌧", "🌹", "🐿", "🐣", "🌼"],
        5 : ["🏄‍♂️", "🕶", "👙", "🐚", "🌻", "🌴", "🍹", "☀️"],
        6 : ["🌰", "🥧", "🌆", "🍂", "🎃", "🏮", "🎑", "🍊"]
    ]
}

