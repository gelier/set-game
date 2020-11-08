//
//  Symbol.swift
//  Concentration1
//
//  Created by Guiller Dalit on 10/31/20.
//  Copyright © 2020 The Window Specialist, Inc. All rights reserved.
//

import Foundation
import SwiftUI
class Symbol: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
