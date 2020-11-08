//  Card.swift
//  Concentration24
//
//  Created by Keith Perry on 2/5/20.
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}


