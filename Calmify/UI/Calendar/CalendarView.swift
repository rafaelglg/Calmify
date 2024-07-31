//
//  Calendar.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 8/6/24.
//

import SwiftUI

struct CalendarView: View {
    
    let emojis = ["😍","😡"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                ScrollView {
                    VStack {
                        HStack {
                            ForEach(emojis, id: \.self) {
                                Text($0)
                            }
                        }
                        Spacer()
                        CalendarCreator()
                    }
                }
                .navigationTitle("Calmify")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    CalendarView()
}

struct CalendarCreator: UIViewRepresentable {
    let interval: DateInterval = DateInterval(start: .distantPast, end: .distantFuture)
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendar = UICalendarView()
        calendar.delegate = context.coordinator
        calendar.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendar.selectionBehavior = dateSelection
        return calendar
    }
    
    // Send data from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    //Send data from SwiftUI to UIKit
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
}

class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    
    var parent: CalendarCreator
    var decorations: [Date?: UICalendarView.Decoration] = [:]
    
    init(parent: CalendarCreator ) {
        self.parent = parent
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents else {return}
        print("selected date \(String(describing: dateComponents.day))")
    }
    

    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        let valentinesDay = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            year: 2024,
            month: 2,
            day: 14
        )
        
        // Create a calendar decoration for Valentine's day.
        let heart = UICalendarView.Decoration.image(
            UIImage(systemName: "heart.fill"),
            color: UIColor.red,
            size: .large)
        
        decorations = [valentinesDay.date: heart]
        
        let day = DateComponents(
            calendar: dateComponents.calendar,
            year: dateComponents.year,
            month: dateComponents.month,
            day: dateComponents.day
        )
        
        // Return any decoration saved for that date.
        return decorations[day.date]
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        true
    }
    
}
