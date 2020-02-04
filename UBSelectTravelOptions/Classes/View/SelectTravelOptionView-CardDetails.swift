//
//  SelectTravelOptionView-CardDetails.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

extension SelectTravelOptionView {
    
    func setupViewWithCardDetails() {
        let viewWithPaymentDetails: UIView = self._viewWithPaymentDetails
        viewWithPaymentDetails.clipsToBounds = true
        viewWithPaymentDetails.backgroundColor = .clear
        let sizeOfViewWithDetails: CGSize = CGSize(width: self._screenWidth, height: self.heightViewWithPaymentDetails)
        viewWithPaymentDetails.frame.size = sizeOfViewWithDetails
        viewWithPaymentDetails.frame.origin = CGPoint(x: 0, y: self._originYViewCardWithDetails)
        let padding: CGFloat = self._padding
        let config: SelectTravelOptionViewConfiguration = self._configuration
        // Line on the top
        let lineView: UIView = UIView()
        lineView.backgroundColor = self._lineColor
        lineView.frame.size = CGSize(width: self._screenWidth - 2*padding, height: 1)
        lineView.center = CGPoint(x: self._screenWidth/2, y: 2)
        
        // Image brand card
        let imageViewCard: UIImageView = self._imageViewCardBrand
        imageViewCard.image = self._configuration.imageForNoCardSelected
        imageViewCard.backgroundColor = config.colors.imageViewCardBackground
        imageViewCard.layer.masksToBounds = true
        imageViewCard.layer.cornerRadius = 1
        imageViewCard.frame.size = CGSize(width: 25, height: 20)
        imageViewCard.frame.origin.x = padding
        imageViewCard.center.y = sizeOfViewWithDetails.height/2 + 2
        imageViewCard.contentMode = .scaleAspectFit
        
        // Image arrow down
        let imageViewArrowDown: UIImageView = self._imageViewArrowDown
        imageViewArrowDown.contentMode = .scaleAspectFit
        imageViewArrowDown.image = UIImage.getFrom(customClass: SelectTravelOptionView.self, nameResource: "iconArrowPicker")?.withRenderingMode(.alwaysTemplate)
        imageViewArrowDown.tintColor = config.colors.imageViewArrowDownTintColor
        imageViewArrowDown.frame.size = CGSize(width: 15, height: 15)
        imageViewArrowDown.center.y = imageViewCard.center.y
        imageViewArrowDown.frame.origin.x = self._screenWidth - self._padding - imageViewArrowDown.frame.size.width
        imageViewArrowDown.backgroundColor = .clear
        
        if !self._configuration.hasPaymentCreditCard{
            imageViewArrowDown.isHidden = true
        }
        
        // Label card number crip
        let label: UILabel = self._labelCardNumberCrip
        label.frame.size = CGSize(width: lineView.frame.size.width - 70, height: sizeOfViewWithDetails.height - 4)
        label.center = CGPoint(x: lineView.center.x, y: imageViewCard.center.y)
        label.numberOfLines = 2
        self.setLabelCardNumberCrip(normalText: self.textForNoCard, discount: nil)
        
        viewWithPaymentDetails.addSubview(lineView)
        viewWithPaymentDetails.addSubview(imageViewCard)
        viewWithPaymentDetails.addSubview(imageViewArrowDown)
        viewWithPaymentDetails.addSubview(label)
        self.addSubview(viewWithPaymentDetails)
        self.setupButtonCard()
    }
    
    var textForNoCard: String {
        let text: String = String.noCardSelectedText(self.language)
        return text
    }
    
    func setLabelCardNumberCrip(normalText: String, discount: Double?) {
        let mutableAttributedString = NSMutableAttributedString()
        let config: SelectTravelOptionViewConfiguration = self._configuration
        let attributesNormal = [NSAttributedString.Key.font: config.fonts.numberCrip,
                                NSAttributedString.Key.foregroundColor: config.colors.numberCripText] as  [NSAttributedString.Key : Any]
        let attributesGreen = [NSAttributedString.Key.font: config.fonts.discountText,
                               NSAttributedString.Key.foregroundColor: config.colors.discountText] as  [NSAttributedString.Key : Any]
        mutableAttributedString.append(NSAttributedString(string: normalText, attributes: attributesNormal))
        if let discount = discount,
            discount != 0.00 {
            let text: String = String.youSaveText(self.language)
            let fullText: String = "\n\(text)\(self._configuration.currency)\(String(format: "%.2f", discount).replacingOccurrences(of: ".", with: ","))"
            mutableAttributedString.append(NSAttributedString(string: fullText, attributes: attributesGreen))
        }
        self._labelCardNumberCrip.attributedText = mutableAttributedString
    }
    
    func updateLabelCardNumberCripWith(discount: Double?) {
        let normalText: String = self._card?.numberCrip ?? self.textForNoCard
        self.setLabelCardNumberCrip(normalText: normalText, discount: discount)
    }
    
}
