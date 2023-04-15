//
//  DateHelper.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 15.04.2023.
//

import Foundation

final class DateHelper {
    static let shared = DateHelper()
    var dateTimes: [Date] = []
    private init() {}
    
    func dateFromString(with dateStr: String) -> Date {
        let curDate = Date()
        let cal = Calendar.current
    
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: dateStr)!
        
        var todayComponents = DateComponents()
        todayComponents.timeZone = .current
        todayComponents.calendar = .current
        todayComponents.day = cal.component(.day, from: curDate)
        todayComponents.year = cal.component(.year, from: curDate)
        todayComponents.month = cal.component(.month, from: curDate)
        todayComponents.hour = cal.component(.hour, from: date)
        todayComponents.minute = cal.component(.minute, from: date)
        todayComponents.second = 0
        
        return todayComponents.date!
    }
    
    func findCurrentTime() -> (nowIdx: Int, remainTime: TimeInterval) {
        let currentDate = Date()
        var idx = 0
        var remainTime: TimeInterval!

        if (dateTimes[0]...dateTimes[1]).contains(currentDate) {
            idx = 0
            remainTime = dateTimes[1].timeIntervalSince1970 - currentDate.timeIntervalSince1970
        } else if (dateTimes[1]...dateTimes[2]).contains(currentDate) {
            idx = 1
            remainTime = dateTimes[2].timeIntervalSince1970 - currentDate.timeIntervalSince1970
        } else if (dateTimes[2]...dateTimes[3]).contains(currentDate) {
            idx = 2
            remainTime = dateTimes[3].timeIntervalSince1970 - currentDate.timeIntervalSince1970
        } else if (dateTimes[3]...dateTimes[4]).contains(currentDate) {
            idx = 3
            remainTime = dateTimes[4].timeIntervalSince1970 - currentDate.timeIntervalSince1970
        } else if (dateTimes[4]...dateTimes[5]).contains(currentDate) {
            idx = 4
            remainTime = dateTimes[5].timeIntervalSince1970 - currentDate.timeIntervalSince1970
        } else if dateTimes[5] > currentDate || dateTimes[0] < currentDate {
            idx = 5
            if dateTimes[5] > currentDate {
                
            }
            remainTime = dateTimes[1].timeIntervalSince1970 - currentDate.timeIntervalSince1970
        }

        
        
        return (idx, remainTime)
    }
    
}
