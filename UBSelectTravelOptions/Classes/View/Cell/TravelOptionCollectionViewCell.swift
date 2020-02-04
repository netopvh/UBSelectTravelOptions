//
//  TravelOptionCollectionViewCell.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

class TravelOptionCollectionViewCell: UICollectionViewCell {
    
    var view: TravelOptionView!
    var _selected: Bool = false
    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let rect: CGRect = CGRect.init(origin: .zero, size: self.frame.size)
        let view = TravelOptionView.instance(frame: rect)
        self.addSubview(view)
        self.view = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
