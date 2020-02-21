//
//  Utility.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 1/28/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import Foundation

enum Utility {
    static func getDaysInMonth(_ date: Date) -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date))
        let converedDate = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: converedDate)!
        let numDays = range.count

        return numDays
    }

    static func addMonth(_ date: Date, month: Int) -> Date {
        guard let convertedDate = Calendar.current.date(byAdding: .month, value: month, to: date) else {
            return Date()
        }
        return convertedDate
    }

    static func getDayOfWeek(_ date: Date) -> Int? {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
    }

    static func startOfMonth(_ date: Date) -> Date {
         guard let convertedDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: date))) else {
             return Date()
         }
         return convertedDate
     }
}
