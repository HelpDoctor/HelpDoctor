//
//  TransitionDriver.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 21.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

enum TransitionDirection {
    case present, dismiss
}

class TransitionDriver: UIPercentDrivenInteractiveTransition {
    func link(to controller: UIViewController) {
        presentedController = controller
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(recognizer:)))
        presentedController?.view.addGestureRecognizer(panRecognizer!)
    }
    
    private var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    // MARK: - Override
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        
        set { }
    }
    
    // MARK: - Direction
    var direction: TransitionDirection = .present
    
    @objc private func handle(recognizer: UIPanGestureRecognizer) {
        switch direction {
        case .present:
            handlePresentation(recognizer: recognizer)
        case .dismiss:
            handleDismiss(recognizer: recognizer)
        }
    }
    
}

// MARK: - Gesture Handling
extension TransitionDriver {
    
    private func handlePresentation(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause()
        case .changed:
            let increment = -recognizer.incrementToBottom(maxTranslation: maxTranslation)
            update(percentComplete + increment)
            
        case .ended, .cancelled:
            if recognizer.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                cancel()
            } else {
                finish()
            }
            
        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
    private func handleDismiss(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            pause() // Без паузы percentComplete всегда равен 0
            
            if !isRunning {
                presentedController?.dismiss(animated: true) // Start the new one
            }
            
        case .changed:
            update(percentComplete + recognizer.incrementToBottom(maxTranslation: maxTranslation))
            
        case .ended, .cancelled:
            if recognizer.isProjectedToDownHalf(maxTranslation: maxTranslation) {
                finish()
            } else {
                cancel()
            }
            
        case .failed:
            cancel()
            
        default:
            break
        }
    }
    
    var maxTranslation: CGFloat {
        return presentedController?.view.frame.height ?? 0
    }
    
    private var isRunning: Bool {
        return percentComplete != 0
    }
    
}

private extension UIPanGestureRecognizer {
    
    func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)
        
        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }
    
    func isProjectedToDownHalf(maxTranslation: CGFloat) -> Bool {
        let endLocation = projectedLocation(decelerationRate: .fast)
        let isPresentationCompleted = endLocation.y > maxTranslation / 2
        
        return isPresentationCompleted
    }
    
    func projectedLocation(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let projectedLocation = location(in: view!) + velocityOffset
        return projectedLocation
    }
    
}

extension CGPoint {
    
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(x: x.projectedOffset(decelerationRate: decelerationRate),
                       y: y.projectedOffset(decelerationRate: decelerationRate))
    }
    
}

extension CGFloat { // Velocity value
    
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // Magic formula from WWDC
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
    
}

extension CGPoint {
    //swiftlint:disable operator_whitespace
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x,
                       y: left.y + right.y)
    }
    
}
