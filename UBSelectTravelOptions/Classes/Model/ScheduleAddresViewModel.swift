//
//  ScheduleAddresViewModel.swift
//  UBSelectTravelOptions
//
//  Created by Usemobile on 25/09/19.
//

import Foundation

open class ScheduleAddresViewModel {
    
    public var originStreet: String
    public var originNeighborhood: String
    public var destinyStreet: String
    public var destinyNeighborhood: String
     
    public init(originStreet: String,
         originNeighborhood: String,
         destinyStreet: String,
         destinyNeighborhood: String) {
        self.originStreet = originStreet
        self.originNeighborhood = originNeighborhood
        self.destinyStreet = destinyStreet
        self.destinyNeighborhood = destinyNeighborhood
    }
}
