//
//  ViewController.swift
//  concentrationApp
//
//  Created by dm on 23.05.2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // FIXME: print(cardButtons.firstIndex(of: sender))
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateVuewFromModel()
        } else {
            print("choosen card not in set \(sender)")
        }
    }
    
    func updateVuewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["💣", "🛡", "🔪", "⚰️", "🧿", "💈", "💊", "🔫", "🔭", "🦠", "⏰"]

    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
        }
    }
    

}

