//
//  Item.swift
//  pillbell
//
//  Created by Leen Almejarri on 08/06/1445 AH.
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
