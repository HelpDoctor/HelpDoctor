//
//  UIFont+Extensions.swift
//  TasksManagerApp
//
//  Created by Mikhail Semerikov on 15.12.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func titleFont(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Ubuntu", size: size) else {
            fatalError("""
                Failed to load the "Ubuntu" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func systemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "FiraSans-Regular", size: size) else {
            fatalError("""
                Failed to load the "FiraSans-Regular" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func italicSystemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "FiraSans-Italic", size: size) else {
            fatalError("""
                Failed to load the "FiraSans-Italic" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func boldSystemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "FiraSans-Bold", size: size) else {
            fatalError("""
                Failed to load the "FiraSans-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func semiBoldSystemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "FiraSans-SemiBold", size: size) else {
            fatalError("""
                Failed to load the "FiraSans-SemiBold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func mediumSystemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "FiraSans-Medium", size: size) else {
            fatalError("""
                Failed to load the "FiraSans-Medium" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func lightSystemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Roboto-Light", size: size) else {
            fatalError("""
                Failed to load the "Roboto-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func thinSystemFontOfSize(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Roboto-Thin", size: size) else {
            fatalError("""
                Failed to load the "Roboto-Thin" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
}
