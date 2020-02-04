//
//  SelectTravelOptionView-CollectionViewProtocols.swift
//  UXUberClone
//
//  Created by Claudio Madureira Silva Filho on 17/12/18.
//  Copyright © 2018 usemobile. All rights reserved.
//

import UIKit

extension SelectTravelOptionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        let height: CGFloat = self._state == .big ? self._bigHeight : self._smallCollectionHeight
        let size: CGSize = CGSize(width: self._screenWidth, height: height)
        if self._collectionView == nil {
            let rect: CGRect = CGRect(origin: .zero, size: size)
            let layout: UICollectionViewFlowLayout = .init()
            layout.sectionInset = .zero
            layout.itemSize = self._state == .small ? self._smallCellSize : self._bigCellSize
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            self._collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        } else {
            self._collectionView.frame.origin = .zero
        }
        self._collectionView.frame.size = size
        guard self._collectionView.superview != self else { return }
        self._collectionView.showsHorizontalScrollIndicator = false
        self._collectionView.delegate = self
        self._collectionView.dataSource = self
        self._collectionView.backgroundColor = .clear
        self._collectionView.addGestureRecognizer(self._panGesture)
        self._collectionView.register(TravelOptionCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self._collectionView.register(OptionWithoutPriceCell.self, forCellWithReuseIdentifier: "cell2")
        self._collectionView.collectionViewLayout.invalidateLayout()
        self._collectionView.reloadData()
        self.addSubview(self._collectionView)
    }
    
    func cell(for index: Int) -> TravelOptionCollectionViewCell? {
        return self._collectionView.cellForItem(at: [0, index]) as? TravelOptionCollectionViewCell
    }
    
    func viewTravelOptionForCellAt(_ index: Int) -> TravelOptionView? {
        return self.cell(for: index)?.view
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self._animator != nil {
            if UIDevice.isInfinteScreen {
                return self._state != .big ? self._bigCellSize : self._smallCellSize
            } else {
                return .zero
            }
        }
        return self._state == .big ? self._bigCellSize : self._smallCellSize
    }
    
    // MARK: - UICollectionViewDataSource
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return self._travelOptions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let travelOption = self._travelOptions[index]
        let size = self.state == .big ? self._bigCellSize : self._smallCellSize
        let config = self._configuration
        let selected = self._selectedIndex == index
        if self._configuration.hasPaymentInfo {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TravelOptionCollectionViewCell
            cell.index = index
            cell._selected = selected
            let rect = CGRect(origin: .zero, size: size)
            cell.view.setup(frame: rect,
                            originYViewDetails: self._showingFakeViewDetailsTravelOptionOriginY,
                            selected: selected,
                            state: self._state,
                            index: index,
                            option: travelOption,
                            padding: self._padding,
                            lineColor: self._lineColor,
                            configuration: config)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! OptionWithoutPriceCell
            cell.index = index
            cell._selected = selected
            cell.imagePlaceholder = self._configuration.imagePlaceholderForOption
            cell.travelOption = travelOption
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newIndex = indexPath.row
        let oldIndex = self._selectedIndex
        if newIndex == oldIndex {
            self.animate(to: self._state.opposite)
        } else {
            let travelOption = self._travelOptions[newIndex]
            if let cell = collectionView.cellForItem(at: indexPath) as? OptionWithoutPriceCell {
                cell._selected = true
                cell.animateSelected(true)
                (collectionView.cellForItem(at: IndexPath(item: self._selectedIndex, section: 0)) as? OptionWithoutPriceCell)?.animateSelected(false)
                self._selectedIndex = newIndex
            } else {
                
                self.updateLabelCardNumberCripWith(discount: travelOption.discount)
                self.setButtonRequestTitle(selectedIndex: newIndex)
                let fakeOld = self._fakeTravelOptionViews[oldIndex]
                let fakeNew = self._fakeTravelOptionViews[newIndex]
                fakeOld.setSelected(false, to: .small)
                fakeNew.setSelected(true, to: .small)
                let cellOld = self.viewTravelOptionForCellAt(oldIndex)
                let cellNew = self.viewTravelOptionForCellAt(newIndex)
                cellOld?.animateSelected(false, to: .small)
                cellNew?.animateSelected(true, to: .small, completion: {
                    self.delegate?.didChangeSelection(self, optionSelected: self._travelOptions[newIndex])
                    collectionView.reloadData()
                })
                self._selectedIndex = newIndex
                self.calculateSmallRects()
                self.calculateBigRects()
            }
        }
    }
    
    func updateSelectionToAllOptions(collectionView: UICollectionView, newSelectedIndex: Int) {
        let oldIndex: Int = self._selectedIndex
        self.setButtonRequestTitle(selectedIndex: newSelectedIndex)
        let travelOption = self._travelOptions[newSelectedIndex]
        self.updateLabelCardNumberCripWith(discount: travelOption.discount)
        let fakeOld = self._fakeTravelOptionViews[oldIndex]
        let fakeNew = self._fakeTravelOptionViews[newSelectedIndex]
        fakeOld.setSelected(false, to: self._state)
        fakeNew.setSelected(true, to: self._state)
        let cellOld = self.viewTravelOptionForCellAt(oldIndex)
        let cellNew = self.viewTravelOptionForCellAt(newSelectedIndex)
        cellOld?.animateSelected(false, to: self._state)
        cellNew?.animateSelected(true, to: self._state, completion: {
            collectionView.reloadData()
        })
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let view = self.viewTravelOptionForCellAt(indexPath.row)
        view?.alpha = 0.3
        self._fakeBackButton.alpha = 0.3
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let view = self.viewTravelOptionForCellAt(indexPath.row)
        view?.alpha = 1
        self._fakeBackButton.alpha = 1
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                          withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self._isDragging = false
        guard self._state == .big else { return }
        let pageFloat = targetContentOffset.pointee.x/scrollView.frame.width
        let page = Int(pageFloat)
        guard page != self._selectedIndex,
            !self._isDragging else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            guard !self._isDragging else { return }
            let cell = self.viewTravelOptionForCellAt(page)
            let travelOption = self._travelOptions[page]
            self.updateLabelCardNumberCripWith(discount: travelOption.discount)
            self.setButtonRequestTitle(selectedIndex: page)
            cell?.animateSelected(true, to: .big, completion: {
                self.delegate?.didChangeSelection(self, optionSelected: self._travelOptions[page])
                self._collectionView.reloadData()
            })
            let oldIndex: Int = self._selectedIndex
            let viewOld = self._fakeTravelOptionViews[oldIndex]
            viewOld.setSelected(false, to: .big)
            let viewNew = self._fakeTravelOptionViews[page]
            viewNew.setSelected(true, to: .big)
            self._selectedIndex = page
            self.calculateSmallRects()
            self.calculateBigRects()
            for (index, view) in self._fakeTravelOptionViews.enumerated() {
                view.frame.origin.x = self._fakeTravelOptionViewRectsBig[index].origin.x
            }
        })
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self._isDragging = true
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch self._state {
        case .small:
            let page = Double(scrollView.contentOffset.x/(scrollView.frame.width))
            let current: Int = Int(ceil(page))
            self._pageControl.currentPage = current
            guard self._state == .small else { return }
            let offsetX: CGFloat = scrollView.contentOffset.x
            for (index, view) in self._fakeTravelOptionViews.enumerated() {
                view.frame.origin.x = -offsetX + CGFloat(index) * self._smallCellSize.width
            }
            self.calculateSmallRects()
            self.calculateBigRects()
            
        case .big:
            let selectedIndex: Int = self._selectedIndex
            let maximum: Int = self._maximumOptionsPerPage
            let finalPage: Int = Int(ceil(Double(selectedIndex)/Double(maximum)))
            self._pageControl.currentPage = finalPage
        }
    }
    
    
    
    
}
