//
//  ViewController.swift
//  Concentration1
//  Edited by Guiller Dalit on 09/08/20
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
import Foundation
import UIKit
class Concentration {
    var cards = [Card]()
    /* cards are duplicated because the card is removed from the cards when the player flip a matched, so when the player click the newGame the orginal cards are still exist
     */
    var duplicateCards = [Card]()
    var perviousIndex: Int?
    /* tracking the first index to set card[firstIndex].isMatched = true, if ever the player flip a match */
    var firstCardIndex: Int?
    // count the flips
    var flipCount = 0
    //  number of cards to be on the table
    var cardsDrawn  = 12
    // card selection- to track how many cards are selected for conditions
    var cardSelected = 0
    // this tracks the number of flips use to enable the dealThree button
    var cardTracker = 0
    // if there's a match set this to true
    var aMatched = false
    // check if the condition is met to disable the dealThree button
    var disbleDealThree = false
    // when flipCards button is clicked this is the flag
    var flipUp = false
    //enum determines the combination of colors
    enum shapeColor {
        case brightColor, darkColor, randomColor, defaultColor
    }
      // shapes to be used
      var emojiShapes = ["■", "▲", "●", "■", "▲", "●", "■", "▲", "●", "■", "▲", "●", "■", "▲", "●", "■", "▲", "●", "■", "▲", "●", "■", "▲", "●", "■", "▲", "●",]
      
      /* converted shapes stored in NSAttributedString dictionary and array, respectively */
      var emoji = [Int:NSAttributedString]()
      var chosenEmoji = [NSAttributedString]()
    var points = 0;
    
    /*randomly select which emoji to be used for the concentration game,
     to randomly select which one is to generate random number between 1 to 5 and based on the number a emoji is assigned in the switch statment*/
    func dealThree() {
        cardsDrawn += 3
        chooseCard(at: -1)
        
    }
    // flip all cards
    func flipCards() {
        
        if flipUp == false {
            for index in cards.indices {
                cards[index].isFaceUp = true
            }
            flipUp = true
        }
        else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            flipUp = false
        }
    }
      // setup the emoji shapes
     func pickEmoji(){
         
         chosenEmoji = []
         emoji.removeAll()
        let font = UIFont.systemFont(ofSize: 60)
         for shape in emojiShapes {
             let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                 .foregroundColor: UIColor.brightColor
             ]
             let attributedString = NSAttributedString(string: shape, attributes: attributes )
             chosenEmoji += [attributedString]
         }
     }
   /*Used the chosen emoji*/
    func emoji(for card: Card) -> NSAttributedString {
        
        if emoji[card.identifier] == nil, chosenEmoji.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(chosenEmoji.count)))
            emoji[card.identifier] = chosenEmoji.remove(at: randomIndex)
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red
        ]
        let attributedString = NSAttributedString(string: "?", attributes: attributes )
        return emoji[card.identifier] ?? attributedString
    }
    
    /*Shuffle the cards*/
    func shuffleCard(){
        cards.shuffle()
    }
    /*reset the cards isMatched and isFaceUp to false*/
    func resetCard(at index: Int){
        cards[index].isMatched = false
        cards[index].isFaceUp = false
    }
    func chooseCard(at index: Int) {
        if index < 0 {
            return
        }
        if index < cards.count {
            if !cards[index].isMatched{
                if let matchIndex = perviousIndex, matchIndex != index {
                    // check if cards match
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cardSelected += 1
                        // if card selection hit three, player made a match
                        if cardSelected == 3 {
                            if let firstCard = firstCardIndex {
                                disbleDealThree = false
                                cards[firstCard].isMatched = true
                                cards[matchIndex].isMatched = true
                                cards[index].isMatched = true
                                aMatched = true
                                points += 3
                            }
                            points += 10
                            cardSelected = 0
                            return
                        }
                    }
                    else{
                        // no match
                        if cardSelected == 2 {
                            disbleDealThree = true
                        }
                        points -= 4
                        aMatched = false
                        perviousIndex = nil
                        cardSelected = 0
                    }
                    cards[index].isFaceUp = true
                    
                }
                else if let matchIndex = perviousIndex, matchIndex == index {
                    points -= 1
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                }else {
                    
                    if cardSelected == 0 {
                        firstCardIndex = index
                        cardSelected += 1
                        
                    }
                    // the points won't go below 0
                    if (points < 0){
                        points = 0
                    }
                    //either no cards or 2 are face up
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                    cards[index].isFaceUp = true
                    perviousIndex = index
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card, card]
        }
        //duplicate the cards for new game
        duplicateCards = cards
    }
}
// Extension UIColor
extension UIColor {
    static var brightColor: UIColor {
        return .init(hue: .random(in: 0...1), saturation: .random(in: 0.3...1), brightness: .random(in: 0.6...1), alpha: .random(in: 0.6...1))
    }
    static var darkColor: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: .random(in: 0.3...1), alpha: 1)
    }
    static var randomColor: UIColor {
        return .init(hue: .random(in: 0...1), saturation: .random(in: 0...1), brightness: 1, alpha: 1)
    }
    static var defaultColor: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
//



