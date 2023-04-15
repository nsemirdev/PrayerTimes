//
//  UIApplication+.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit

extension UIApplication {
    
    static func getSafeAreaBottom() -> CGFloat {
        let window = UIApplication.shared.connectedScenes.first!
        return (window as? UIWindowScene)!.windows.first!.safeAreaInsets.bottom
    }
    
    static func getSafeAreaTop() -> CGFloat {
        let window = UIApplication.shared.connectedScenes.first!
        return (window as? UIWindowScene)!.windows.first!.safeAreaInsets.top
    }
}
