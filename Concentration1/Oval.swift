//
//  CardView.swift
//  Concentration1
//
//  Created by Guiller Dalit on 10/31/20.
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
//

import SwiftUI

class Oval: Symbol {
    // init the view with a rectangular frame
    
    var path: UIBezierPath!
    var index: Int!
    
    func createOval() {
         path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    override func draw(_ rect: CGRect) {
          self.createOval()
    }
    
}
