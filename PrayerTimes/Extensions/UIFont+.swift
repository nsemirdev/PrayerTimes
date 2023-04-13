//
//  UIFont+.swift
//  PrayerTimes
//
//  Created by Emir Alkal on 13.04.2023.
//

import UIKit

extension UIFont {
    /*
     CeraPro-Italic
     CeraPro-Light
     CeraPro-Medium
     CeraPro-Bold
     CeraPro-Black
     CeraPro-BlackItalic
*/
    static func ceraItalic(size: CGFloat) -> UIFont {
        .init(name: "CeraPro-Italic", size: size)!
    }
    
    static func ceraLight(size: CGFloat) -> UIFont {
        .init(name: "CeraPro-Light", size: size)!
    }
    
    static func ceraMedium(size: CGFloat) -> UIFont {
        .init(name: "CeraPro-Medium", size: size)!
    }
    
    static func ceraBold(size: CGFloat) -> UIFont {
        .init(name: "CeraPro-Bold", size: size)!
    }
    
    static func ceraBlack(size: CGFloat) -> UIFont {
        .init(name: "CeraPro-Black", size: size)!
    }
    
    static func ceraBlackItalic(size: CGFloat) -> UIFont {
        .init(name: "CeraPro-BlackItalic", size: size)!
    }
}
