//
//  SelectTravelOptionView-Animator.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

extension SelectTravelOptionView {
    
    func animateIfNeeded(to state: SelectTravelOptionViewState) {
        guard self._animator == nil else { return }
        let isBigState = state == .big
        self._fakeCollectionView.alpha = 1
        self._collectionView.alpha = 0
        let duration = self._configuration.animationDuration
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: nil)
        let alpha0: CGFloat = -2
        let alpha0_2: CGFloat = self._hiddenAlphaBackButton
        let alpha1: CGFloat = 1
        let heightForCollectionView = isBigState ? self._bigHeight : self._smallCollectionHeight
        self.setSelectedOptionDetailsToFakeView()
        if self._darkViewBack.superview != self.superview {
            self.superview?.insertSubview(self._darkViewBack, belowSubview: self)
        }
        if isBigState {
            self._fakeTravelOptionViews.forEach({ view in
                view.viewDetails.alpha = 0
            })
        } else {
            self._fakeViewDetailsTravelOption.alpha = 1
        }
        animator.addAnimations {
            self.frame.size.height = isBigState ? self._bigHeight : self._smallHeight
            self.frame.origin.y = isBigState ? self._bigOriginY : self._smallOriginY
            self._darkViewBack.alpha = isBigState ? 1 : 0
            self._pageControl.alpha = isBigState ? alpha0 : self._alphaPageControl
            self._pageControl.frame.origin.y = isBigState ? self._hiddingOriginYPageControl : self._originYPageControl
            self._debtView.alpha = isBigState ? alpha0 : alpha1
            self._buttonRequestTravel.alpha = isBigState ? alpha0 : alpha1
            self._buttonScheduleTravel.alpha = self._buttonRequestTravel.alpha
            self._buttonRequestTravel.frame.origin.y = isBigState ? self._bigHeight : self._showingRequestButtonOriginY
            self._buttonScheduleTravel.frame.origin.y = self._buttonRequestTravel.frame.origin.y
            self._viewWithPaymentDetails.alpha = isBigState ? alpha0 : alpha1
            self._viewWithPaymentDetails.frame.origin.y = isBigState ? self._hiddingOriginYViewCardWithDetails : self._originYViewCardWithDetails
            self._collectionView.frame.size.height = heightForCollectionView
            self._fakeCollectionView.frame.size.height = heightForCollectionView
            self._fakeBackButton.frame.origin.y = isBigState ? self._showingOriginYFakeBackButton : self._hiddingOriginYFakeBackButton
            self._fakeBackButton.alpha = isBigState ? alpha1 : alpha0_2
            self._fakeViewDetailsTravelOption.frame.origin.y = isBigState ? self._showingFakeViewDetailsTravelOptionOriginY : self._hiddingFakeViewDetailsTravelOptionOriginY
            self._fakeViewDetailsTravelOption.alpha = isBigState ? alpha1 : alpha0_2
            self._couponView.alpha = isBigState ? alpha0 : alpha1
            self._fakeCollectionView.layoutIfNeeded()
            self.updateFakeCollectionLayout(to: state)
            self.layoutIfNeeded()
        }
        animator.addCompletion { position in
            self._animator = nil
            self._state = self._state.opposite
            self._collectionView.collectionViewLayout.invalidateLayout()
            self._collectionView.reloadData()
            self._collectionView.isPagingEnabled = state == .big
            let indexPath: IndexPath = [0, self._selectedIndex]
            if isBigState {
                self._collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            } else {
                self._collectionView.scrollToItem(at: indexPath, at: self.getPosition(), animated: false)
            }
            self.scrollViewDidScroll(self._collectionView)
            self._collectionView.alpha = 1
            self._fakeCollectionView.alpha = 0
            self._fakeViewDetailsTravelOption.alpha = self._hiddenAlphaBackButton
            self.layoutIfNeeded()
            self.calculateSmallRects()
            self.calculateBigRects()
        }
        self._animator = animator
    }
    
    func getPosition() -> UICollectionView.ScrollPosition {
        let index: Int = self._selectedIndex
        let count: Int = self._travelOptions.count
        switch index {
        case 0:
            return .left
        case count - 1:
            return .right
        default:
            return .centeredHorizontally
        }
    }
    
}
