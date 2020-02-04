//
//  FakeBackButtonLabel.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

class FakeBackButtonLabel: UILabel {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.borderColor = self.textColor.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
}
