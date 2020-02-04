//
//  Colors.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 19/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

public class SelectTravelOptionViewColors {
    // Buttons
    public var buttonRequestBackground: UIColor
    public var buttonRequestTitleColor: UIColor
    public var buttonBackBackground: UIColor
    public var buttonBackTitleAndBorderColor: UIColor
    public var buttonCouponTitleColor: UIColor
    public var buttonCouponSelectedColor: UIColor
    
    // Labels
    public var labelTravelOptionType: UIColor
    public var labelTravelOptionPrice: UIColor
    public var labelTravelOptionDiscount: UIColor
    public var labelTravelOptionDetailsLeft: UIColor
    public var labelTravelOptionDetailsRight: UIColor
    public var labelTravelOptionDescription: UIColor
    public var numberCripText: UIColor
    public var discountText: UIColor
    
    // Icons
    public var imageViewArrowDownTintColor: UIColor
    public var imageViewCardBackground: UIColor
    
    // General
    public var pageControlPageIndicator: UIColor
    public var pageControlCurrentPage: UIColor
    public var progress: UIColor
    public var darkViewBackground: UIColor
    public var noOptions: UIColor
    public var scheduleMainColor: UIColor
    public var scheduleSecondaryColor: UIColor
    
    public static var `default`: SelectTravelOptionViewColors {
        return SelectTravelOptionViewColors(buttonRequestBackground: .black,
                                            buttonRequestTitleColor: .white,
                                            buttonBackBackground: .white,
                                            buttonBackTitleAndBorderColor: .black,
                                            buttonCouponTitleColor: .black,
                                            buttonCouponSelectedColor: .black,
                                            labelTravelOptionType: .black,
                                            labelTravelOptionPrice: .black,
                                            labelTravelOptionDiscount: .lightGray,
                                            labelTravelOptionDetailsLeft: .lightGray,
                                            labelTravelOptionDetailsRight: .gray,
                                            labelTravelOptionDescription: .lightGray,
                                            numberCripText: .black,
                                            discountText: UIColor(red: 0.41, green: 0.57, blue: 0.37, alpha: 1.0),
                                            imageViewArrowDownTintColor: .lightGray,
                                            imageViewCardBackground: .lightGray,
                                            pageControlPageIndicator: .lightGray,
                                            pageControlCurrentPage: .black,
                                            progress: .black,
                                            darkViewBackground: UIColor.black.withAlphaComponent(0.7),
                                            noOptions: .lightGray,
                                            scheduleMainColor: .blue,
                                            scheduleSecondaryColor: .white)
    }
    
    public init(buttonRequestBackground: UIColor,
                buttonRequestTitleColor: UIColor,
                buttonBackBackground: UIColor,
                buttonBackTitleAndBorderColor: UIColor,
                buttonCouponTitleColor: UIColor,
                buttonCouponSelectedColor: UIColor,
                labelTravelOptionType: UIColor,
                labelTravelOptionPrice: UIColor,
                labelTravelOptionDiscount: UIColor,
                labelTravelOptionDetailsLeft: UIColor,
                labelTravelOptionDetailsRight: UIColor,
                labelTravelOptionDescription: UIColor,
                numberCripText: UIColor,
                discountText: UIColor,
                imageViewArrowDownTintColor: UIColor,
                imageViewCardBackground: UIColor,
                pageControlPageIndicator: UIColor,
                pageControlCurrentPage: UIColor,
                progress: UIColor,
                darkViewBackground: UIColor,
                noOptions: UIColor,
                scheduleMainColor: UIColor,
                scheduleSecondaryColor: UIColor) {
        self.buttonRequestBackground = buttonRequestBackground
        self.buttonRequestTitleColor = buttonRequestTitleColor
        self.buttonBackBackground = buttonBackBackground
        self.buttonBackTitleAndBorderColor = buttonBackTitleAndBorderColor
        self.buttonCouponTitleColor = buttonCouponTitleColor
        self.buttonCouponSelectedColor = buttonCouponSelectedColor
        self.labelTravelOptionType = labelTravelOptionType
        self.labelTravelOptionPrice = labelTravelOptionPrice
        self.labelTravelOptionDiscount = labelTravelOptionDiscount
        self.labelTravelOptionDetailsLeft = labelTravelOptionDetailsLeft
        self.labelTravelOptionDetailsRight = labelTravelOptionDetailsRight
        self.labelTravelOptionDescription = labelTravelOptionDescription
        self.numberCripText = numberCripText
        self.discountText = discountText
        self.imageViewArrowDownTintColor = imageViewArrowDownTintColor
        self.imageViewCardBackground = imageViewCardBackground
        self.pageControlPageIndicator = pageControlPageIndicator
        self.pageControlCurrentPage = pageControlCurrentPage
        self.progress = progress
        self.darkViewBackground = darkViewBackground
        self.noOptions = noOptions
        self.scheduleMainColor = darkViewBackground
        self.scheduleSecondaryColor = noOptions
    }
}
