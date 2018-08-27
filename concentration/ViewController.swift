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
    
    private lazy var game = Concentration(numOfPairsOfCards: numberOfPairsOfCards)

    private var themeIndex: Int = 0
    private var emojiDict = Dictionary<Int, String>()
    var numberOfPairsOfCards: Int {
        return (cardButtons.count  + 1) /  2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not in cardButtons")
        }
    }
    
    @IBAction private func newGameButton(_ sender: UIButton) {
        game = Concentration(numOfPairsOfCards: cardButtons.count / 2)
        themeIndex = pickRandomTheme()
        game.resetFlipCount()
        updateViewFromModel()
    }
    
    // MARK: Helper functions
    private func updateViewFromModel() {
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
    
    private func emoji(for card: Card, withTheme index: Int) -> String {
        if emojiDict[card.identifier] == nil, emojiThemesDict.count > 0 {
            
            for key in emojiThemesDict.keys {
                if key == index {
                    if var currentTheme = emojiThemesDict[key] {
                        emojiDict[card.identifier] = currentTheme.remove(at: currentTheme.count.arc4random)
                        emojiThemesDict[key] = currentTheme
                    }
                }
            }
        }
        
        return emojiDict[card.identifier] ?? "?"
    }
    
    private func pickRandomTheme() -> Int {
        return Int(arc4random_uniform(UInt32(emojiThemesDict.keys.count)))
    }
    
    // MARK: Available Themes
    private var emojiThemesDict = [
        0 : ["😀", "🙂", "🤪", "🤩", "😤", "😱", "😐", "🤠"],
        1 : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        2 : ["🍏", "🍐", "🍌", "🍉", "🍇", "🍒", "🥥", "🌶"],
        3 : ["⛸", "☕️", "❄️", "☃️", "🧤", "🧦", "🧣", "🛷"],
        4 : ["🌂", "🌈", "☔️", "🌧", "🌹", "🐿", "🐣", "🌼"],
        5 : ["🏄‍♂️", "🕶", "👙", "🐚", "🌻", "🌴", "🍹", "☀️"],
        6 : ["🌰", "🥧", "🌆", "🍂", "🎃", "🏮", "🎑", "🍊"]
    ]
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

