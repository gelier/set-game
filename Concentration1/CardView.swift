//
//  CardView.swift
//  Concentration1
//
//  Created by Admin on 10/31/20.
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
//

import SwiftUI

class CardView: UIButton {
    // init the view with a rectangular frame
    
    var path: UIBezierPath!
    var index: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createRectangle() {
        path = UIBezierPath()
        
        path.move(to: CGPoint(x:0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path = UIBezierPath(roundedRect: self.bounds,
        byRoundingCorners: [.topLeft, .bottomRight],
        cornerRadii: CGSize(width: 60.0, height: 0.0))
        path.close()
    }
    func setIndex(index: Int){
        self.index = index
    }
    
    override func draw(_ rect: CGRect) {
        self.createRectangle()
        UIColor.white.setFill()
        path.fill()
        UIColor.white.setStroke()
        path.stroke()
    }
    
}
