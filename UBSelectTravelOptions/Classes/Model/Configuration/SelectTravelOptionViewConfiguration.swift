//
//  SelectTravelOptionViewConfiguration.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

public class SelectTravelOptionViewConfiguration {
    public var animationDuration: TimeInterval
    public var language: Language
    public var imagePlaceholderForOption: UIImage?
    public var imageForNoCardSelected: UIImage?
    public var imageInfo: UIImage?
    public var imageNoOptions: UIImage?
    public var imageClose: UIImage?
    public var currency: String
    public var fonts: SelectTravelOptionViewFonts
    public var colors: SelectTravelOptionViewColors
    public var hasDetails: Bool
    public var hasPaymentInfo: Bool
    public var hasPaymentCreditCard: Bool
    public var hasSchedule: Bool
    
    public static var defaultConfiguration: SelectTravelOptionViewConfiguration {
        return SelectTravelOptionViewConfiguration(animationDuration: 0.3,
                                                   language: .en,
                                                   imagePlaceholderForOption: nil,
                                                   imageForNoCardSelected: nil,
                                                   imageInfo: nil,
                                                   imageNoOptions: nil,
                                                   imageClose: nil,
                                                   currency: "R$",
                                                   fonts: .default,
                                                   colors: .default)
    }
    
    public init(animationDuration: TimeInterval,
                language: Language,
                imagePlaceholderForOption: UIImage?,
                imageForNoCardSelected: UIImage?,
                imageInfo: UIImage?,
                imageNoOptions: UIImage?,
                imageClose: UIImage?,
                currency: String,
                fonts: SelectTravelOptionViewFonts,
                colors: SelectTravelOptionViewColors,
                hasDetails: Bool = true,
                hasPaymentInfo: Bool = true,
                hasPaymentCreditCard: Bool = true,
                hasSchedule: Bool = false) {
        self.animationDuration = animationDuration
        self.language = language
        self.imagePlaceholderForOption = imagePlaceholderForOption
        self.imageForNoCardSelected = imageForNoCardSelected
        self.imageInfo = imageInfo
        self.imageNoOptions = imageNoOptions
        self.imageClose = imageClose
        self.currency = currency
        self.fonts = fonts
        self.colors = colors
        self.hasDetails = hasDetails
        self.hasPaymentInfo = hasPaymentInfo
        self.hasPaymentCreditCard = hasPaymentCreditCard
        self.hasSchedule = hasSchedule
    }
    
}

public enum Language: String {
    case pt = "pt-BR"
    case en = "en-US"
    case es = "es-BO"
    var isPT: Bool {
        return self == .pt
    }
}
