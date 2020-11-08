//
//  CardView.swift
//  Concentration1
//
//  Created by Guiller Dalit on 10/31/20.
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
//

import SwiftUI

class Triangle: Symbol {
    // init the view with a rectangular frame
    
    var path: UIBezierPath!
    
    func createTriangle() {
       path = UIBezierPath()
       path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
       path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
       path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
       path.close()
    }
    override func draw(_ rect: CGRect) {
        self.createTriangle()
    }
    
}
