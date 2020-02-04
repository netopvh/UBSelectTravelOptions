//
//  AA.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 19/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

public class SelectTravelOptionViewFonts {
    // TravelOption
    public var travelOptionType: UIFont
    public var travelOptionPrice: UIFont
    public var travelOptionDiscount: UIFont
    public var travelOptionDetailsLeft: UIFont
    public var travelOptionDetailsRight: UIFont
    public var travelOptionDescription: UIFont
    
    // General
    public var numberCrip: UIFont
    public var discountText: UIFont
    public var buttonRequest: UIFont
    public var buttonBack: UIFont
    public var noOptions: UIFont
    public var buttonCouponTitle: UIFont
    public var buttonCouponSelected: UIFont
    
    public static var `default`: SelectTravelOptionViewFonts {
        return SelectTravelOptionViewFonts(travelOptionType: UIFont.systemFont(ofSize: 24, weight: .semibold),
                                           travelOptionPrice: UIFont.systemFont(ofSize: 14, weight: .regular),
                                           travelOptionDiscount: UIFont.systemFont(ofSize: 14, weight: .regular),
                                           travelOptionDetailsLeft: UIFont.systemFont(ofSize: 15, weight: .regular),
                                           travelOptionDetailsRight: UIFont.systemFont(ofSize: 15, weight: .regular),
                                           travelOptionDescription: UIFont.systemFont(ofSize: 13, weight: .light),
                                           numberCrip: UIFont.systemFont(ofSize: 14, weight: .light),
                                           discountText: UIFont.systemFont(ofSize: 14, weight: .light),
                                           buttonRequest: UIFont.systemFont(ofSize: 18, weight: .regular),
                                           buttonBack: UIFont.systemFont(ofSize: 18, weight: .regular),
                                           noOptions: UIFont.systemFont(ofSize: 18, weight: .light),
                                           buttonCouponTitle: UIFont.systemFont(ofSize: 17, weight: .semibold),
                                           buttonCouponSelected: UIFont.systemFont(ofSize: 17))
    }
    
    public init(travelOptionType: UIFont,
                travelOptionPrice: UIFont,
                travelOptionDiscount: UIFont,
                travelOptionDetailsLeft: UIFont,
                travelOptionDetailsRight: UIFont,
                travelOptionDescription: UIFont,
                numberCrip: UIFont,
                discountText: UIFont,
                buttonRequest: UIFont,
                buttonBack: UIFont,
                noOptions: UIFont,
                buttonCouponTitle: UIFont,
                buttonCouponSelected: UIFont) {
        self.travelOptionType = travelOptionType
        self.travelOptionPrice = travelOptionPrice
        self.travelOptionDiscount = travelOptionDiscount
        self.travelOptionDetailsLeft = travelOptionDetailsLeft
        self.travelOptionDetailsRight = travelOptionDetailsRight
        self.travelOptionDescription = travelOptionDescription
        self.numberCrip = numberCrip
        self.discountText = discountText
        self.buttonRequest = buttonRequest
        self.buttonBack = buttonBack
        self.noOptions = noOptions
        self.buttonCouponTitle = buttonCouponTitle
        self.buttonCouponSelected = buttonCouponSelected
    }
}
