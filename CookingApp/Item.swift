//
//  Item.swift
//  CookingApp
//
//  Created by Kalyan Hari on 4/22/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
