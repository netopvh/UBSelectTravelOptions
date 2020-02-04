//
//  SelectTravelOptionView-Progress.swift
//  UberUXClone
//
//  Created by Claudio Madureira Silva Filho on 18/12/18.
//  Copyright © 2018 Claudio Madureira Silva Filho. All rights reserved.
//

import UIKit

public extension SelectTravelOptionView {
    
    func setupProgress() {
        self._viewProgress.alpha = 0
        self._viewProgress.frame.size.width = self._screenWidth
        self._viewProgress.frame.origin.x = 0
        self.addSubview(self._viewProgress)
    }
    
    public func startProgress(with fakeOptions: TravelOptions? = nil, completion: (() -> Void)? = nil) {
        self.reloadDebtView(hasDebt: false)
        self._couponView.isHidden = true
        let fakeTravelOptions: TravelOptions = fakeOptions ?? self._travelOptions.withoutDetails
        if !fakeTravelOptions.isEmpty {
//            self.setTravelOptionsAnimated(fakeTravelOptions)
            self.setTravelOptionsAnimated(fakeTravelOptions, completion: { _ in
                completion?()
            })
        }
        guard !self.isProgressAnimating else { return }
        let loadingText: String = String.searchingText(self.language)
        self._buttonRequestTravel.setTitle(loadingText, for: .normal)
        self._buttonRequestTravel.isEnabled = false
        self._buttonScheduleTravel.isEnabled = false
        self.updateLabelCardNumberCripWith(discount: nil)
        self._collectionView.isUserInteractionEnabled = false
        
        let layer = CAShapeLayer()
        let size: CGSize = CGSize(width: self._screenWidth/4, height: self._viewProgress.frame.height)
        let rect: CGRect = CGRect(origin: .zero, size: size)
        layer.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
        layer.fillColor = self._configuration.colors.progress.cgColor
        
        self._viewProgress.layer.addSublayer(layer)
        
        let duration: TimeInterval = 1.2
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position.x")
        positionAnimation.values = [0, self._screenWidth, 0]
        positionAnimation.keyTimes = [0, 0.5, 1]
        positionAnimation.duration = duration
        positionAnimation.repeatCount = Float.greatestFiniteMagnitude
        positionAnimation.isAdditive = true
        
        let widthAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
        widthAnimation.values = [0, 1, 0, 1, 0]
        widthAnimation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        widthAnimation.duration = duration
        widthAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        
        self._viewProgress.alpha = 1
        layer.add(positionAnimation, forKey: "position")
        layer.add(widthAnimation, forKey: "width")
        
        UIView.animate(withDuration: 0.15, animations: {
            self._viewNoOptions.alpha = 0
            self._collectionView.alpha = fakeTravelOptions.isEmpty ? 0 : 1
            self._pageControl.alpha = fakeTravelOptions.count <= self._maximumOptionsPerPage ? 0 : 1
        })
    }
    
    func stopProgressWith(message: String) {
        self.labelStopMessage.text = message
        self._collectionView.isUserInteractionEnabled = true
        if self._travelOptions.isEmpty {
            self.setTravelOptions([])
            UIView.animate(withDuration: 0.15, animations: {
                self._collectionView.alpha = 0
                self._pageControl.alpha = -2
                self._viewNoOptions .alpha = 1
                self._viewProgress.alpha = 0
            }) { _ in
                let animationLayer: CALayer? = self._viewProgress.layer.sublayers?.first
                animationLayer?.removeAllAnimations()
                animationLayer?.removeFromSuperlayer()
                self.setButtonRequestTitle(selectedIndex: 0)
            }
        } else {
            self.setTravelOptionsAnimated([])
            UIView.animate(withDuration: 0.15, animations: {
                self._viewProgress.alpha = 0
            }) { _ in
                let animationLayer: CALayer? = self._viewProgress.layer.sublayers?.first
                animationLayer?.removeAllAnimations()
                animationLayer?.removeFromSuperlayer()
                self.setButtonRequestTitle(selectedIndex: self._selectedIndex)
            }
        }
    }
    
    func stopProgressWith(newOptions: TravelOptions, debtValue: Double? = nil) {
        self.labelStopMessage.text = String.noOptions(self.language)
        self._collectionView.isUserInteractionEnabled = true
        if let _debtValue = debtValue, _debtValue > 0 {
            self.reloadDebtView(hasDebt: !newOptions.isEmpty, debtValue: _debtValue)
        } else {
            self.reloadDebtView(hasDebt: false)
        }
        if self._travelOptions.isEmpty {
            self.setTravelOptions(newOptions)
            UIView.animate(withDuration: 0.15, animations: {
                self._collectionView.alpha = newOptions.isEmpty ? 0 : 1
                self._pageControl.alpha = newOptions.isEmpty ? -2 : (self._state == .big ? -2 : 1)
                self._viewNoOptions.alpha = newOptions.isEmpty ? 1 : 0
                self._viewProgress.alpha = 0
            }, completion: { _ in
                let animatingLayer: CALayer? = self._viewProgress.layer.sublayers?.first
                animatingLayer?.removeAllAnimations()
                animatingLayer?.removeFromSuperlayer()
                self.setButtonRequestTitle(selectedIndex: 0)
            })
        } else {
            self.setTravelOptionsAnimated(newOptions)
            UIView.animate(withDuration: 0.15, animations: {
                self._viewProgress.alpha = 0
            }, completion: { _ in
                let animatingLayer: CALayer? = self._viewProgress.layer.sublayers?.first
                animatingLayer?.removeAllAnimations()
                animatingLayer?.removeFromSuperlayer()
                self.setButtonRequestTitle(selectedIndex: self._selectedIndex)
            })
        }
    }
    
    var isProgressAnimating: Bool {
        if let sublayers = self._viewProgress.layer.sublayers {
            return !sublayers.isEmpty
        }
        return false
    }
    
}
