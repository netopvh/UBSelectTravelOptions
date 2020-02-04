//
//  SelectTravelOptionView-GestureProtocols.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

extension SelectTravelOptionView: UIGestureRecognizerDelegate {
    
    @objc func onDrag(_ gesture: UIPanGestureRecognizer) {
        guard self._configuration.hasDetails else { return }
        switch gesture.state {
        case .began:
            self.animateIfNeeded(to: self._state.opposite)
            self._fakeCollectionView.alpha = 1
            self._collectionView.alpha = 0
        case .changed:
            let translation = gesture.translation(in: self._collectionView)
            let y = translation.y
            let state = self._state
            guard (state == .small && y < 0) || (state == .big && y > 0) else { return }
            let fraction = abs(y / (self._bigHeight/2))
            self._animator?.fractionComplete = fraction
        case .ended:
            self._animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    override public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard self._configuration.hasDetails else { return false }
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let vel = pan.velocity(in: pan.view)
            let y = vel.y
            let x = vel.x
            let isBig = self._state == .big
            return (abs(y) > abs(x)) && ((isBig && y > 0) || (!isBig && y < 0))
        }
        return true
    }
    
}
