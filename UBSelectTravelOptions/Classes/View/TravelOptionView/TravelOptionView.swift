//
//  TravelOptionView.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 14/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

class TravelOptionView: UIView {
    
    @IBOutlet weak var imv: ImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var constTopImageView: NSLayoutConstraint!
    @IBOutlet weak var imv2: UIImageView!
    @IBOutlet weak var constCenterXPrice: NSLayoutConstraint!
    @IBOutlet weak var constHeightInfo: NSLayoutConstraint!
    
    let smallFontSize: CGFloat = 15
    let bigFontSize: CGFloat = 22
    var _selected: Bool = false
    var state: SelectTravelOptionViewState = .small
    var travelOption: TravelOption!
    let proportionSelected: CGFloat = 1.25
    let proportionBig: CGFloat = 1.5
    let labelProportion: CGFloat = 0.65
    var index: Int = 0
    let viewDetailsWidth: CGFloat = UIScreen.main.bounds.width - 50
    let tableViewCellHeight: CGFloat = 40
    let numberOfItems: Int = 3
    var imagePlaceholder: UIImage?
    var viewDetails: DetailsTravelOptionView = DetailsTravelOptionView()
    var iconInfo: UIImage?
    var originYViewDetails: CGFloat = 0
    var currency: String = ""
    
    class func instance(frame rect: CGRect) -> TravelOptionView {
        let bundle = Bundle(for: TravelOptionView.self)
        let view = UINib(nibName: "\(TravelOptionView.self)", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)[0] as! TravelOptionView
        view.frame = rect
        return view
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(self.viewDetails)
    }
    
    func setup(frame rect: CGRect,
               originYViewDetails: CGFloat,
               selected: Bool,
               state: SelectTravelOptionViewState,
               index: Int,
               option: TravelOption,
               padding: CGFloat,
               lineColor: UIColor,
               configuration: SelectTravelOptionViewConfiguration) {
        self.frame = rect
        self.state = state
        self.index = index
        self.lblPrice.font = configuration.fonts.travelOptionPrice
        self.lblDiscount.font = configuration.fonts.travelOptionDiscount
        self.currency = configuration.currency
        self.originYViewDetails = originYViewDetails
        self.iconInfo = configuration.imageInfo
        self.setImageInfo()
        self.imagePlaceholder = configuration.imagePlaceholderForOption
        self.setLayoutTo(state: state, selected: selected)
        self.layoutIfNeeded()
        self.setupTravelOption(option)
        self.setImageInfoTo(selected: selected, state: state)
        self.setupViewDetails(padding: padding,
                              lineColor: lineColor,
                              configuration: configuration)
        self.viewDetails.alpha = state == .big ? 1 : 0
        self.lblType.textColor = .black
        self.lblPrice.textColor = .black
        self.lblDiscount.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
    }
    
    func setupTravelOption(_ item: TravelOption) {
        self.travelOption = item
        self.setPrice(item: item)
        self.setDiscount(item: item)
        self.lblType.text = item.type
        self.lblType.sizeToFit()
        self.setImage(selected: self._selected)
    }
    
    func setPrice(item: TravelOption) {
        if item.price != nil {
            self.lblPrice.text = "\(self.currency)\(String(format: "%.2f", item.finalPrice()).replacingOccurrences(of: ".", with: ","))"
        } else {
            self.lblPrice.text = nil
        }
    }
    
    func setDiscount(item: TravelOption) {
        if let discount = item.discount,
            discount != 0.00 {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(self.currency)\(String(format: "%.2f", discount).replacingOccurrences(of: ".", with: ","))")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: NSMakeRange(0, attributeString.length))
            self.lblDiscount.attributedText = attributeString
        } else {
            self.lblDiscount.attributedText = nil
        }
    }
    
    func setupViewDetails(padding: CGFloat,
                          lineColor: UIColor,
                          configuration: SelectTravelOptionViewConfiguration) {
        
        self.viewDetails.frame.origin.y = self.originYViewDetails
        self.viewDetails.center.x = UIScreen.main.bounds.width/2
        self.viewDetails.setItems(item: self.travelOption, language: configuration.language, currency: configuration.currency)
        self.viewDetails.setup(padding: padding,
                               lineColor: lineColor,
                               language: configuration.language,
                               textLeftColor: configuration.colors.labelTravelOptionDetailsLeft,
                               textRightColor: configuration.colors.labelTravelOptionDetailsRight,
                               textLeftFont: configuration.fonts.travelOptionDetailsLeft,
                               textRightFont: configuration.fonts.travelOptionDetailsRight)
    }
    
    func setLayoutTo(state: SelectTravelOptionViewState, selected: Bool) {
        self._selected = selected
        self.setImageSizeWith(selected: selected, state: state)
        self.lblType.transform = state == .big ? .identity : CGAffineTransform.init(scaleX: labelProportion, y: labelProportion)
        self.lblPrice.alpha = state == .big ? 0 : 1
        self.lblDiscount.alpha = state == .big ? -0.2 : 1
        self.setImageInfoTo(selected: selected, state: state)
        self.layoutIfNeeded()
    }
    
    func animateSelected(_ selected: Bool, to state: SelectTravelOptionViewState, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.15, animations: {
            self.setSelected(selected, to: state)
        }, completion: { _ in
            completion?()
        })
    }
    
    func setTravelOptionAnimated(_ travelOption: TravelOption, completion: (() -> Void)? = nil) {
        self.travelOption = travelOption
        let isSelected: Bool = self._selected
        let isEmptyPrice: Bool = self.lblPrice.text == nil
//        UIView.animate(withDuration: 0, animations: {
            self.setImage(selected: isSelected)
//            if !isEmptyPrice {
//                self.setImageInfoTo(selected: isSelected, state: self.state)
//            }
//            self.lblPrice.alpha = 0
//            self.lblDiscount.alpha = 0
//        }, completion: { _ in
            self.setPrice(item: travelOption)
            self.setDiscount(item: travelOption)
//            UIView.animate(withDuration: 0, animations: {
                self.setImageInfoTo(selected: isSelected, state: self.state)
                self.lblPrice.alpha = self.state  == .big ? 0 : 1
                self.lblDiscount.alpha = self.state  == .big ? 0 : 1
//            }, completion: { _ in
                completion?()
//            })
//        })
    }
    
    func setSelected(_ selected: Bool, to state: SelectTravelOptionViewState) {
        self._selected = selected
        self.setImageInfoTo(selected: selected, state: state)
        self.setImageSizeWith(selected: selected, state: state)
        self.setImage(selected: selected)
        self.layoutIfNeeded()
    }
    
    func setImageInfoTo(selected: Bool, state: SelectTravelOptionViewState) {
        self.setImageInfo()
        let isNil: Bool = self.travelOption != nil ? self.travelOption.price != nil : false
        self.constHeightInfo.constant = selected && state != .big && isNil ? 15 : 0
        self.constCenterXPrice.constant = selected && state != .big && isNil ? -9 : 0
        self.layoutIfNeeded()
    }
    
    func setImageInfo() {
        self.imv2.image = self.iconInfo ?? UIImage.getFrom(customClass: TravelOptionView.self, nameResource: "iconInfo")
    }
    
    func setImageSizeWith(selected: Bool, state: SelectTravelOptionViewState) {
        switch state {
        case .big:
            let _proportion = proportionBig*proportionSelected
            self.imv.transform = selected ? CGAffineTransform(scaleX: _proportion, y: _proportion) : CGAffineTransform(scaleX: proportionBig, y: proportionBig)
        case .small:
            self.imv.transform = selected ? CGAffineTransform(scaleX: proportionSelected, y: proportionSelected) : CGAffineTransform.identity
        }
    }
    
    func setImageCircle() {
        self.imv.layer.masksToBounds = true
        self.imv.layer.cornerRadius = self.imv.frame.size.width/2
    }
    
    func setImage(selected: Bool) {
        let option = self.travelOption!
        let nameOrURL = selected ? option.selectedImageNameOrURL : option.imageNameOrURL
        if self.validateUrl(urlString: nameOrURL),
            let url = URL(string: nameOrURL) {
            self.imv.castImage(from: url, with: self.imagePlaceholder)
        } else {
            let image = UIImage(named: nameOrURL)
            self.imv.image = image ?? self.imagePlaceholder
        }
    }
    
    func validateUrl(urlString: String) -> Bool {
        guard urlString.count > 5 else { return false }
        var aux = ""
        let array = Array(urlString)
        for i in 0..<5 {
            aux.append(array[i])
        }
        return aux.contains("http")
    }
    
}
