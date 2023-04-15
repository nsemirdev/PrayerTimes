//
//  PrayerItemViewModel.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import Foundation
import NetworkManager

class PrayerTimesViewModel {
    
    weak var delegate: PrayerTimesViewModelDelegate?
    var timeIntervals = [TimeInterval]()
    
    func didReceivePrayerTimes(prayerTimes: PrayerTimes) {
        let placeName = "\(prayerTimes.place.city), \(prayerTimes.place.country)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy, EEEE"
        let date = dateFormatter.string(from: Date())
        
        var prayerTimeDates = [Date]()
        prayerTimes.times.forEach {
            prayerTimeDates.append(
                DateHelper.shared.dateFromString(with: $0)
            )
        }
        DateHelper.shared.dateTimes = prayerTimeDates
        let (now, remain) = DateHelper.shared.findCurrentTime()
        let presentationObject = PrayerTimesPresentation(
            placeName: placeName,
            remainTime: remain,
            date: date,
            nowItemIdx: now,
            times: prayerTimes.times
        )
        delegate?.updateView(with: presentationObject)
    }
    
    func didReceiveError(error: Error) {
        delegate?.updateViewWithError()
    }
}



protocol PrayerTimesViewModelDelegate: AnyObject {
    func updateView(with item: PrayerTimesPresentation)
    func updateViewWithError()
    func invalidateTimer()
}
