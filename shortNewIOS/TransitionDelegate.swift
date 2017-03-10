//
//  TransitionDelegate.swift
//  shortNewIOS
//
//  Created by SSd on 12/17/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import Foundation
import UIKit

class TransitionDelegate : NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let controller = AnimatedTransitioning()
        return controller
        
    }
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
