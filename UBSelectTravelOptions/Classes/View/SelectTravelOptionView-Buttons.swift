//
//  SelectTravelOptionView-Buttons.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

extension SelectTravelOptionView {
    
    func setupButtonRequest() {
        var buttonWidth: CGFloat = self._screenWidth - self._padding
        if self._configuration.hasSchedule {
            buttonWidth -= (54 + 18)
        }
        let size: CGSize = CGSize(width: buttonWidth, height: 50)
        self._buttonRequestTravel.frame.size = size
        self._buttonRequestTravel.layer.masksToBounds = true
        self._buttonRequestTravel.layer.cornerRadius = size.height/2
        self._buttonRequestTravel.frame.origin.x = self._padding / 2
        self._buttonRequestTravel.frame.origin.y = self._showingRequestButtonOriginY
        let config = self._configuration
        self._buttonRequestTravel.backgroundColor = config.colors.buttonRequestBackground
        self._buttonRequestTravel.titleLabel?.font = config.fonts.buttonRequest
        self.setTargets(to: self._buttonRequestTravel)
        self.addSubview(self._buttonRequestTravel)
    }
    
    func setupButtonCard() {
        self._buttonSelectCard.frame.size = CGSize(width: self._screenSize.width - 2*self._padding, height: self._viewWithPaymentDetails.frame.height)
        self._buttonSelectCard.center = CGPoint(x: self._screenWidth/2, y: self._viewWithPaymentDetails.frame.height/2)
        self.setTargets(to: self._buttonSelectCard)
        self._viewWithPaymentDetails.addSubview(self._buttonSelectCard)
    }
    
    func setupButtonSchedule() {
        guard self._configuration.hasSchedule else { return }
        let x: CGFloat = self._buttonRequestTravel.frame.origin.x + self._buttonRequestTravel.frame.size.width + 18
        let y: CGFloat = self._buttonRequestTravel.frame.origin.y
        let size: CGFloat = self._buttonRequestTravel.frame.size.height
        self._buttonScheduleTravel.frame = CGRect(x: x, y: y, width: size, height: size)
        self._buttonScheduleTravel.setImage(UIImage.getFrom(customClass: SelectTravelOptionView.self, nameResource: "schedule"), for: .normal)
        self._buttonScheduleTravel.addTarget(self, action: #selector(self.schedule), for: .touchUpInside)
        self._buttonScheduleTravel.isEnabled = !self._configuration.hasPaymentCreditCard
        self._buttonScheduleTravel.tintColor = self._configuration.colors.buttonRequestBackground
        self.addSubview(self._buttonScheduleTravel)
    }
    
    @objc func schedule() {
        self.delegate?.didTapSchedule(self, on: { [weak self](dateViewModel: ScheduleDateViewModel, scheduleViewModel: ScheduleAddresViewModel) in
            guard let self = self else { return }
            self.presentSchedulePreview(dateViewModel: dateViewModel, scheduleViewModel: scheduleViewModel)
        })
    }
    
    func setTargets(to button: UIButton) {
        button.addTarget(self, action: #selector(self.touchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(self.touchDragInside(_:)), for: .touchDragInside)
        button.addTarget(self, action: #selector(self.touchDragOutside(_:)), for: .touchDragOutside)
        button.addTarget(self, action: #selector(self.touchUpInside(_:)), for: .touchUpInside)
    }
    
    @objc func touchDown(_ sender: UIButton) {
        self.setHightlightedState(to: sender)
    }
    
    @objc func touchDragInside(_ sender: UIButton) {
        self.setHightlightedState(to: sender)
    }
    
    @objc func touchDragOutside(_ sender: UIButton) {
        self.setNormalState(to: sender)
    }
    
    @objc func touchUpInside(_ sender: UIButton) {
        self.setNormalState(to: sender)
        if sender == self._buttonRequestTravel {
            guard !self.isProgressAnimating else { return }
            if self._travelOptions.isEmpty {
                self.delegate?.didTapToFetchTravelOptionsAgain(self)
            } else {
                let travelOption = self._travelOptions[self._selectedIndex]
                self.delegate?.didTapToRequestTravel(self, with: travelOption, card: self._card)
            }
        } else {
            self.delegate?.didTapToSelectCard(self)
        }
    }
    
    func setHightlightedState(to button: UIButton) {
        let alpha: CGFloat = 0.4
        if button == self._buttonRequestTravel {
            button.alpha = alpha
        } else {
            self._labelCardNumberCrip.alpha = alpha
            self._imageViewCardBrand.alpha = alpha
            self._imageViewArrowDown.alpha = alpha
        }
    }
    
    func setNormalState(to button: UIButton) {
        if button == self._buttonRequestTravel {
            button.alpha = 1
        } else {
            self._labelCardNumberCrip.alpha = 1
            self._imageViewCardBrand.alpha = 1
            self._imageViewArrowDown.alpha = 1
        }
    }
    
}
