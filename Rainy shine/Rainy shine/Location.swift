//
//  Location.swift
//  Rainy shine
//
//  Created by Anshu Vij on 05/05/18.
//  Copyright © 2018 Anshu Vij. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude : Double!
    var longitutde : Double!
}
