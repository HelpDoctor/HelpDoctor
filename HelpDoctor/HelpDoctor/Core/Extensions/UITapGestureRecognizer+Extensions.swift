//
//  UITapGestureRecognizer+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 09.03.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//
/*
import UIKit

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        guard let attributedText = label.attributedText else { return false }
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let xTextContainerOffset = (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x
        let yTextContainerOffset = (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        print(labelSize.width)
        print(textBoundingBox.size.width)
        print(textBoundingBox.origin.x)
        print(xTextContainerOffset)
        let textContainerOffset = CGPoint(x: xTextContainerOffset,
                                          y: yTextContainerOffset)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                            in: textContainer,
                                                            fractionOfDistanceBetweenInsertionPoints: nil)
        print(indexOfCharacter)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
*/
