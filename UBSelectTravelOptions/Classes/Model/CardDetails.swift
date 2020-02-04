//
//  CardDetails.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

public class CardDetails {
    public let objectId: String
    public let numberCrip: String
    public let image: UIImage
    
    public init(objectId: String,
                numberCrip: String,
                image: UIImage) {
        self.objectId = objectId
        self.numberCrip = numberCrip
        self.image = image
    }
}
