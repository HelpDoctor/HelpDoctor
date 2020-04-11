//
//  UIView+Extensions.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 11.04.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

extension UIView {
    
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func createBorder(side: ViewSide,
                      thickness: CGFloat,
                      color: UIColor,
                      leftOffset: CGFloat = 0,
                      rightOffset: CGFloat = 0,
                      topOffset: CGFloat = 0,
                      bottomOffset: CGFloat = 0) -> CALayer {
        
        switch side {
        case .top:
            // Bottom Offset Has No Effect
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            return _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                    y: 0 + topOffset,
                                                    width: self.frame.size.width - leftOffset - rightOffset,
                                                    height: thickness), color: color)
        case .right:
            // Left Has No Effect
            // Subtract bottomOffset from the height to get our end.
            return _getOneSidedBorder(frame: CGRect(x: self.frame.size.width - thickness - rightOffset,
                                                    y: 0 + topOffset,
                                                    width: thickness,
                                                    height: self.frame.size.height), color: color)
        case .bottom:
            // Top has No Effect
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            return _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                    y: self.frame.size.height - thickness - bottomOffset,
                                                    width: self.frame.size.width - leftOffset - rightOffset,
                                                    height: thickness),
                                      color: color)
        case .left:
            // Right Has No Effect
            return _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                    y: 0 + topOffset,
                                                    width: thickness,
                                                    height: self.frame.size.height - topOffset - bottomOffset),
                                      color: color)
        }
    }
    
    func addBorder(side: ViewSide,
                   thickness: CGFloat,
                   color: UIColor,
                   leftOffset: CGFloat = 0,
                   rightOffset: CGFloat = 0,
                   topOffset: CGFloat = 0,
                   bottomOffset: CGFloat = 0) {
        
        switch side {
        case .top:
            // Add leftOffset to our X to get start X position.
            // Add topOffset to Y to get start Y position
            // Subtract left offset from width to negate shifting from leftOffset.
            // Subtract rightoffset from width to set end X and Width.
            let width = self.frame.size.width - leftOffset - rightOffset
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                   y: 0 + topOffset,
                                                                   width: width,
                                                                   height: thickness), color: color)
            self.layer.addSublayer(border)
        case .right:
            // Subtract the rightOffset from our width + thickness to get our final x position.
            // Add topOffset to our y to get our start y position.
            // Subtract topOffset from our height, so our border doesn't extend past teh view.
            // Subtract bottomOffset from the height to get our end.
            let height = self.frame.size.height - topOffset - bottomOffset
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: self.frame.size.width - thickness - rightOffset,
                                                                   y: 0 + topOffset,
                                                                   width: thickness,
                                                                   height: height),
                                                     color: color)
            self.layer.addSublayer(border)
        case .bottom:
            // Subtract the bottomOffset from the height and the thickness to get our final y position.
            // Add a left offset to our x to get our x position.
            // Minus our rightOffset and negate the leftOffset from the width to get our endpoint for the border.
            let width = self.frame.size.width - leftOffset - rightOffset
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                   y: self.frame.size.height - thickness - bottomOffset,
                                                                   width: width,
                                                                   height: thickness),
                                                     color: color)
            self.layer.addSublayer(border)
        case .left:
            let height = self.frame.size.height - topOffset - bottomOffset
            let border: CALayer = _getOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                   y: 0 + topOffset,
                                                                   width: thickness,
                                                                   height: height),
                                                     color: color)
            self.layer.addSublayer(border)
        }
    }
    
    func createViewBackedBorder(side: ViewSide,
                                thickness: CGFloat,
                                color: UIColor,
                                leftOffset: CGFloat = 0,
                                rightOffset: CGFloat = 0,
                                topOffset: CGFloat = 0,
                                bottomOffset: CGFloat = 0) -> UIView {
        
        switch side {
        case .top:
            let width = self.frame.size.width - leftOffset - rightOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                            y: 0 + topOffset,
                                                                            width: width,
                                                                            height: thickness),
                                                              color: color)
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            return border
            
        case .right:
            let x = self.frame.size.width - thickness - rightOffset
            let height = self.frame.size.height - topOffset - bottomOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: x,
                                                                            y: 0 + topOffset, width: thickness,
                                                                            height: height),
                                                              color: color)
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            return border
            
        case .bottom:
            let y = self.frame.size.height - thickness - bottomOffset
            let width = self.frame.size.width - leftOffset - rightOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                            y: y,
                                                                            width: width,
                                                                            height: thickness),
                                                              color: color)
            border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            return border
            
        case .left:
            let height = self.frame.size.height - topOffset - bottomOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                            y: 0 + topOffset,
                                                                            width: thickness,
                                                                            height: height),
                                                              color: color)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
            return border
        }
    }
    
    func addViewBackedBorder(side: ViewSide,
                             thickness: CGFloat,
                             color: UIColor,
                             leftOffset: CGFloat = 0,
                             rightOffset: CGFloat = 0,
                             topOffset: CGFloat = 0,
                             bottomOffset: CGFloat = 0) {
        
        switch side {
        case .top:
            let width = self.frame.size.width - leftOffset - rightOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                            y: 0 + topOffset,
                                                                            width: width,
                                                                            height: thickness),
                                                              color: color)
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            self.addSubview(border)
            
        case .right:
            let x = self.frame.size.width - thickness - rightOffset
            let height = self.frame.size.height - topOffset - bottomOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: x,
                                                                            y: 0 + topOffset,
                                                                            width: thickness,
                                                                            height: height),
                                                              color: color)
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            self.addSubview(border)
            
        case .bottom:
            let y = self.frame.size.height - thickness - bottomOffset
            let width = self.frame.size.width - leftOffset - rightOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                            y: y,
                                                                            width: width,
                                                                            height: thickness),
                                                              color: color)
            border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            self.addSubview(border)
        case .left:
            let height = self.frame.size.width - leftOffset - rightOffset
            let border: UIView = _getViewBackedOneSidedBorder(frame: CGRect(x: 0 + leftOffset,
                                                                            y: 0 + topOffset,
                                                                            width: thickness,
                                                                            height: height),
                                                              color: color)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
            self.addSubview(border)
        }
    }
    
    fileprivate func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border: CALayer = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }
    
    fileprivate func _getViewBackedOneSidedBorder(frame: CGRect, color: UIColor) -> UIView {
        let border: UIView = UIView(frame: frame)
        border.backgroundColor = color
        return border
    }
    
}
