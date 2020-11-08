//
//  CardView.swift
//  Concentration1
//
//  Created by Guiller Dalit on 10/31/20.
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
//

import SwiftUI

class Rectangle: Symbol {
    // init the view with a rectangular frame
    
    var path: UIBezierPath!
    var index: Int!
    
    func createRectangle() {
        path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: [.topLeft, .bottomRight],
                            cornerRadii: CGSize(width: 15.0, height: 0.0))
        
    }
    override func draw(_ rect: CGRect) {
        self.createRectangle()
    }
    
}
