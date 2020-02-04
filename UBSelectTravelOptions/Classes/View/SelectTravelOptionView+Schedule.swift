//
//  SelectTravelOptionView+Schedule.swift
//  Pods-UBSelectTravelOptions_Example
//
//  Created by Usemobile on 23/09/19.
//

import UIKit

public extension SelectTravelOptionView {
    
    func presentSchedulePreview(dateViewModel: ScheduleDateViewModel, scheduleViewModel: ScheduleAddresViewModel) {
        guard self.scheduleView == nil else { return }
        let view = ScheduleView(frame: .init(origin: .zero, size: .init(width: _screenSize.width, height: 315)),
                                travelOption: self.selectedOption,
                                mainColor: self._configuration.colors.scheduleMainColor,
                                secondaryColor: self._configuration.colors.scheduleSecondaryColor)
        view.language = self._configuration.language
        view.dateViewModel = dateViewModel
        view.scheduleViewModel = scheduleViewModel
        view.backAction = { [weak self] in
            guard let self = self else { return }
            self.hideSchedulePreview()
        }
        view.scheduleAction = { [weak self] in
            guard let self = self else { return }
            self.hideSchedulePreview()
            self.delegate?.didRequestSchedule(self)
        }
        view.editDateAction = { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapEditScheduleDate(self, on: { [weak self](dateViewModel: ScheduleDateViewModel?) in
                guard let self = self else { return }
                if let _dateViewModel = dateViewModel {
                    self.scheduleView?.dateViewModel = _dateViewModel
                } else {
                    
                }
            })
        }
        view.alpha = 0
        self.addSubview(view)
        self.scheduleView = view
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = .init(origin: .init(x: 0, y: self._screenSize.height - 315), size: .init(width: self._screenSize.width, height: 315))
            view.alpha = 1
        }) { _ in
            
        }
    }
    
    func hideSchedulePreview() {
        guard let _scheduleView = self.scheduleView else { return }
        UIView.animate(withDuration: 0.4, animations: {
            let height: CGFloat = self._properHeight
            let size: CGSize = CGSize(width: self._screenWidth, height: height)
            let rect: CGRect = CGRect(origin: .init(x: 0, y: self._state == .small ? self._smallOriginY : self._bigOriginY), size: size)
            self.frame = rect
            _scheduleView.alpha = 0
        }) { _ in
            _scheduleView.removeFromSuperview()
            self.scheduleView = nil
            //            UIView.animate(withDuration: 0.4, animations: {
            //            }) { _ in
            //                _scheduleView.removeFromSuperview()
            //                self.scheduleView = nil
            //            }
        }
    }
    
}
