//
//  calender.swift
//  pillbell
//
//  Created by Leen Almejarri on 08/06/1445 AH.
//

import SwiftUI
import  EventKitUI
struct Calender: UIViewRepresentable {
  
    
    
    let interval: DateInterval
     var eventStore: EKEventStore
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, eventStore: eventStore)
      }
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate{
        var parent : Calender
         var eventStore: EKEventStore
        init(parent: Calender, eventStore: EKEventStore) {
            self.parent = parent
            self.eventStore = eventStore
        }
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundEvents = eventStore.events
//                .filter { $0.date.startOfDay == dateComponents.date?.startOfDay}
//            if foundEvents.isEmpty{return nil }
//            if foundEvents.count>1 {return .image(UIImage(systemName: "doc.on.doc.fill")) }
            return nil
        }
    }
    
    
}

