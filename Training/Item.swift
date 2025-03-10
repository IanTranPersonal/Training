//
//  Item.swift
//  Training
//
//  Created by Vinh Tran on 10/3/2025.
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
