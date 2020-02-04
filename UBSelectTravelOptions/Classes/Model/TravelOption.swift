//
//  TravelOption.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

public class TravelOption: NSObject {
    public let objectId: String
    public let type: String
    public var price: Double?
    public var discount: Double?
    public let capacity: String
    public let estimatedArrivalTime: String
    public let imageNameOrURL: String
    public let selectedImageNameOrURL: String
    
    public init(objectId: String,
                type: String,
                price: Double?,
                discount: Double?,
                capacity: String,
                estimatedArrivalTime: String,
                imageNameOrURL: String,
                selectedImageNameOrURL: String) {
        self.objectId = objectId
        self.type = type
        self.price = price
        self.discount = discount
        self.capacity = capacity
        self.estimatedArrivalTime = estimatedArrivalTime
        self.imageNameOrURL = imageNameOrURL
        self.selectedImageNameOrURL = selectedImageNameOrURL
    }
    
    func finalPrice() -> Double {
        let sum = (self.price ?? 0) - (self.discount ?? 0)
        return sum >= 0 ? sum : 0
    }
    
    public static func isEqual(lhs: TravelOption, rhs: TravelOption) -> Bool {
        return lhs.objectId == rhs.objectId
    }
}


public typealias TravelOptions = [TravelOption]


extension Array where Element: TravelOption {
    
    var withoutDetails: TravelOptions {
        var newArray: TravelOptions = .init()
        for item in self {
            let _item = TravelOption(objectId: item.objectId,
                                     type: item.type,
                                     price: nil,
                                     discount: nil,
                                     capacity: item.capacity,
                                     estimatedArrivalTime: item.estimatedArrivalTime,
                                     imageNameOrURL: item.imageNameOrURL,
                                     selectedImageNameOrURL: item.selectedImageNameOrURL)
            newArray.append(_item)
        }
        return newArray
    }
    
}
