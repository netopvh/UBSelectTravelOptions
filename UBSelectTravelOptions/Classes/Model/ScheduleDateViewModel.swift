//
//  ScheduleDateViewModel.swift
//  UBSelectTravelOptions
//
//  Created by Usemobile on 25/09/19.
//

import Foundation

open class ScheduleDateViewModel {
    
    public var day: String
    public var time: String
    
    public init(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "HH:mm"
        self.time = dateFormatter.string(from: date)
    }
    
}
