//
//  WWColorTheme.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWColorTheme: NSObject {
    
    static func brightBlue() -> UIColor {
        return color(red: 0, green: 122, blue: 255)
    }
    
    static func clearBlue() -> UIColor {
        return color(red: 45, green: 145, blue: 253)
    }
    
    static func blackApp() -> UIColor {
        return color(red: 59, green: 59, blue: 59)
    }
    
    static func whiteApp() -> UIColor {
        return color(red: 249, green: 249, blue: 249)
    }
    
    static func whiteTwo() -> UIColor {
        return color(red: 220, green: 220, blue: 220)
    }
    
    static func warmGrey() -> UIColor {
        return color(red: 148, green: 148, blue: 148)
    }
    
    static func reddishPink() -> UIColor {
        return color(red: 255, green: 31, blue: 81)
    }
    
    static func skyBlue() -> UIColor {
        return color(red: 76, green: 188, blue: 255)
    }
    
    static func marigold() -> UIColor {
        return color(red: 254, green: 188, blue: 0)
    }
    
    static func grayCode() -> UIColor {
        return color(red: 40, green: 40, blue: 36)
    }
    
    static func mediumGreen() -> UIColor {
        return color(red: 66, green: 183, blue: 79)
    }
}

private extension WWColorTheme {
    
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}
