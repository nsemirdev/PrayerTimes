//
//  TimeInterval+.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 15.04.2023.
//

import Foundation

extension TimeInterval {
    func hourMinuteFromTimeInterval() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        return String(format: "%0.2d:%0.2d",hours, minutes)
    }
    
    func secondFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60

        return String(format: "%0.2d", seconds)
    }
}
