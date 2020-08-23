//
//  PanelTransition.swift
//  HelpDoctor
//
//  Created by Mikhail Semerikov on 21.08.2020.
//  Copyright © 2020 Mikhail Semerikov. All rights reserved.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let driver = TransitionDriver()
    var frameOfPresentedViewInContainerView: CGRect?
   
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        driver.link(to: presented)
        
        let presentationController = DimmPresentationController(presentedViewController: presented,
                                                                presenting: presenting ?? source)
        presentationController.driver = driver
        if frameOfPresentedViewInContainerView != nil {
            presentationController.frameOfPresentedView = frameOfPresentedViewInContainerView!
        }
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
}
