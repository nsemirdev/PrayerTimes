//
//  UILabel+.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit

extension UILabel {
    convenience init(
        font: UIFont,
        textColor: UIColor
    ) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}
