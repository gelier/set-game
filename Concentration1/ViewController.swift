//
//  ViewController.swift
//  Concentration1
//  Edited by Guiller Dalit on 09/08/20
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.

import UIKit
import SwiftUI
class ViewController: UIViewController {
    
    
    lazy var game = Concentration(numberOfPairsOfCards: (27))
    // @IBOutlet var cardButtons: [UIButton]!
    // contains the count of flips
    @IBOutlet weak var flipCountLabel: UILabel!
    // added label to display points
    @IBOutlet weak var pointsLabel: UILabel!
    // contains the card count
    @IBOutlet weak var cardsCountLabel: UILabel!
    // display a "Nice" when there's a match
    @IBOutlet weak var oneMoreMessage: UILabel!
    // new game button
    @IBOutlet weak var newGame: UIButton!
    // a button to flip the cards
    @IBOutlet weak var flipCards: UIButton!
    // a button to deal three cards
    @IBOutlet weak var dealThree: UIButton!
    
    //StackView
    var cardStackView = [UIStackView]()
    var cardButtons = [CardView]()
    var stoppingIndex = 0
    var whichStack = 0
    override func viewDidLoad() {
        print ("here")
        let pg = CardView(frame:CGRect(x:100, y:200, width:150, height:150))
        self.view.bringSubviewToFront(pg)
    }
    override func viewDidAppear(_ animated: Bool) {
        //New Game
        setupStackView()
        stackViewtopLabels(stackView: cardStackView[0], anchor: 20, start: 0, end: 2)
        stackViewtopLabels(stackView: cardStackView[1], anchor: 175, start: 3, end: 5)
        stackViewtopLabels(stackView: cardStackView[2], anchor: 330, start: 6, end: 8)
        stackViewtopLabels(stackView: cardStackView[3], anchor: 485, start: 9, end: 11)
    }
    /* when dealThree button is clicked disable if the condition is met*/
    @IBAction func drawThreeCards(_ sender: UIButton) {
        game.dealThree()
        if game.disbleDealThree == true {
            dealThree.isEnabled = false
            dealThree.layer.borderColor = UIColor.red.cgColor
        }
        else {
            dealThree.isEnabled = true
            dealThree.layer.borderColor = UIColor.blue.cgColor
            
        }
        if game.cardsDrawn <= 24 {
            for _ in 0..<3 {
                print ("which stack \(whichStack)")
                print ("stoppingIndex \(stoppingIndex)")
                var anchor = 0
                if whichStack == 4 {
                    whichStack = 0
                }
                if whichStack == 0{
                    anchor = 20
                }
                if whichStack == 1{
                    anchor = 175
                }
                if whichStack == 2{
                    anchor = 330
                }
                if whichStack == 3{
                    anchor = 485
                }
                stackViewtopLabels(stackView: cardStackView[whichStack], anchor: anchor, start: stoppingIndex, end: stoppingIndex)
                whichStack += 1
            }
            
        }
        updateViewFromModel()
        
    }
    /*Flip all cards*/
    @IBAction func flipAllCards(_ sender: Any) {
        game.flipCards()
        updateViewFromModel()
    }
    /*when new game button is pressed, set flipCount and points to 0, and set the cards background color to SystemBlue (facing down), and set an empty string to remove the emoji*/
    @IBAction func restartButton(_ sender: UIButton) {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let attributes: [NSAttributedString.Key: Any] = [
                :]
            let attributedString = NSAttributedString(string: "", attributes: attributes )
            button.setAttributedTitle(attributedString, for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
            game.resetCard(at: index)
            button.isEnabled = true
            button.layer.borderWidth = 3.0
            button.layer.borderWidth = 0.0
        }
        game.flipCount = 0
        game.points = 0
        displayScoringView()
        
        game.cards = game.duplicateCards
        game.cardsDrawn = 12
        dealThree.isEnabled = true
        
        // updateViewFromModel()
        
    }
    @objc func cardClick(_ gesture: UITapGestureRecognizer) {
        // updateViewFromModel()
        let card = gesture.view as! CardView
        if game.cardsDrawn > 24 {
            dealThree.isEnabled = false
            dealThree.layer.borderColor = UIColor.red.cgColor
        }
        else {
            //this condition enables the dealThree button after 4 flips
            game.cardTracker += 1
            if  game.cardTracker == 4 {
                game.disbleDealThree = false
                dealThree.isEnabled = true
                dealThree.layer.borderColor = UIColor.blue.cgColor
                game.cardTracker = 0
            }
        }
        /*if flipCoint is 0, meaning it's a new game.
         Therefore, shuffle the cards and pick a random emoji in the
         pickEmoji function defined in the Concentration.swift*/
        if game.flipCount == 0 {
            game.shuffleCard()
            game.pickEmoji()
        }
        if let cardNumber = card.index {
            /* if the card selected is not matched then increment flipCount*/
            if cardNumber < game.cards.count{
                if game.cards[cardNumber].isMatched != true{
                    game.flipCount += 1
                }
                
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print ("Chosen card not in CardButton")
        }
        
        
        
        print("UILabel clicked \(card.index!)")
    }
    func setupStackView () {
        cardStackView.reserveCapacity(4)
        for _ in 0..<4 {
            cardStackView.append(UIStackView())
        }
        cardButtons.reserveCapacity(24)
        for _ in 0..<24 {
            let pg = CardView(frame:CGRect(x:0, y:0, width: self.view.frame.width/3 , height:self.view.frame.height/3 ))
            pg.center = CGPoint(x: 160, y: 285)
            cardButtons.append(pg)
        }
        
    }
    
    
    func stackViewtopLabels (stackView: UIStackView, anchor: Int, start: Int, end: Int) {
        //labels
        
        for index in start...end {
            print (index)
            let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.cardClick(_:)))
            stackView.addArrangedSubview(cardButtons[index])
            cardButtons[index].setIndex(index: index)
            cardButtons[index].addGestureRecognizer(guestureRecognizer)
            stoppingIndex += 1
        }
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        view.addSubview(stackView)
        
        // autolayout constraint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: flipCountLabel.bottomAnchor, constant: CGFloat(anchor)),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
    }
    
    /*function that displays the flipCount and points*/
    func displayScoringView(){
        flipCountLabel.text = "\(game.flipCount)"
        pointsLabel.text = "\(game.points)"
        cardsCountLabel.text = "\(game.cards.count)"
    }
    /*This is a modified version of updateViewFromModel, explanation below*/
    func updateViewFromModel() {
        displayScoringView()
        
        var card = Card()
        for index in cardButtons.indices {
            
            var button = cardButtons[index]
            // only set cards based on the numbers of drawn cards, intially it's 12
            if index < game.cards.count{
                card = game.cards[index]
            }
            else {
                //and disable the other buttons that's not using by the card
                button.isEnabled = false
            }
            
            if index < game.cardsDrawn {
                //set button cornered radius and border width
                button.layer.borderWidth = 3.0
                button.layer.cornerRadius = 8.0
                
                //if card is face up setan AttributedTitle
                if card.isFaceUp {
                    button.setAttributedTitle(game.emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = UIColor.white
                    
                } else {
                    // else if not set a "" attributedString
                    let attributes: [NSAttributedString.Key: Any] = [
                        :]
                    let attributedString = NSAttributedString(string: "", attributes: attributes )
                    button.setAttributedTitle(attributedString, for: UIControl.State.normal)
                    if card.isMatched {
                        /*Display a "Nice!!!" message when there's a match*/
                        oneMoreMessage.isHidden = false
                        UIView.animate(withDuration: 1, animations: { () -> Void in
                            self.oneMoreMessage.alpha = 0
                        })
                        // remove the matched card from the cards
                        game.cards = game.cards.filter {$0.identifier !=  game.cards[index] .identifier}
                        updateViewFromModel()
                    }
                    button.backgroundColor =  UIColor.systemBlue
                }
                
            }
        }
        //set button cornered radius and border width
        dealThree.layer.cornerRadius = 8.0
        dealThree.layer.borderWidth = 3.0
        newGame.layer.cornerRadius = 8.0
        newGame.layer.borderWidth = 3.0
        flipCards.layer.cornerRadius = 8.0
        flipCards.layer.borderWidth = 3.0
        
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
