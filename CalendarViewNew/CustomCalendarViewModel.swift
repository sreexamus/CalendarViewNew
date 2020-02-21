//
//  CustomCalendarViewModel.swift
//  CalendarViewNew
//
//  Created by sreekanth reddy iragam reddy on 2/5/20.
//  Copyright © 2020 CalendarView. All rights reserved.
//

import Foundation

class CustomCalendarViewModel {
    
    func isLessThanDate(_ date: Date, dateToCompare: Date) -> Bool {
        var isLess = false
        if date.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        return isLess
    }
    
    func isGreaterThanDate(_ date: Date, dateToCompare: Date) -> Bool {
        return date.compare(dateToCompare) == ComparisonResult.orderedDescending
    }
    
    func getDaysInMonth(_ date: Date) -> Int {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: calendar.component(.year, from: date), month: calendar.component(.month, from: date))
        let converedDate = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: converedDate)!
        let numDays = range.count
        
        return numDays
    }
    
    func addMonth(_ date: Date, month: Int) -> Date {
        guard let convertedDate = Calendar.current.date(byAdding: .month, value: month, to: date) else {
            return Date()
        }
        return convertedDate
    }
    
    func startOfMonth(_ date: Date) -> Date {
        guard let convertedDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: date))) else {
            return Date()
        }
        return convertedDate
    }
    
    func endOfMonth(_ date: Date) -> Date {
        guard let convertedDate = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date)) else {
            return Date()
        }
        return convertedDate
    }
    
    func getDayOfWeek(_ date: Date) -> Int? {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
    }
    
    func getHeaderTitle(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM YYYY"
        return dateFormatter.string(from: date)
    }
    
    func getDay(_ date: Date, day: Int) -> Date {
        guard let day = Calendar.current.date(byAdding: .day, value: day, to: date),
            let convertedDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: day) else {
                return Date()
        }
        return convertedDate
    }
    
    func getYearOnly(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return dateFormatter.string(from: date)
    }
    
    func getTitleDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM dd"
        return dateFormatter.string(from: date)
    }
    func stripTime(from originalDate: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: originalDate)
        let date = Calendar.current.date(from: components)
        return date!
    }
    
    func getDayName(_ index: Int) -> String {
        return Calendar.current.shortWeekdaySymbols[index]
    }
    
    func getWeekDayName(_ index: Int) -> String {
        return Calendar.current.standaloneWeekdaySymbols[index]
    }
    
    func getMonth(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month
        return month ?? 0
    }
    
    func getYear(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        let year = components.year
        return year ?? 0
    }
    
    func getDayInInt(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let day = components.day
        return day ?? 0
    }
    
}
