//
//  Calendar.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 8/6/24.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                CalendarCreator(interval: DateInterval(start: .distantPast, end: .distantFuture))
            }
            .navigationTitle("Calmify")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CalendarView()
}

struct CalendarCreator: UIViewRepresentable {
    let interval: DateInterval
    func makeUIView(context: Context) -> UICalendarView {

        let calendar = UICalendarView()
        calendar.delegate = context.coordinator
        calendar.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendar.selectionBehavior = dateSelection
        return calendar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
}

class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    var parent: CalendarCreator
    
    init(parent: CalendarCreator ) {
        self.parent = parent
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents else {return}
        print("selected date \(String(describing: dateComponents.day))")
    }
    

    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        true
    }
    
}
