//
//  date.swift
//  pillbell
//
//  Created by Leen Almejarri on 09/06/1445 AH.
//

import Foundation
extension Date{
    func diff(numDays: Int)-> Date{
        Calendar.current.date(byAdding: .day,value: numDays, to: self)!
    }
    var startOfDay: Date{
        Calendar.current.startOfDay(for: self)
    }
}
