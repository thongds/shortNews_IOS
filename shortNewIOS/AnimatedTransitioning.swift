//
//  AnimatedTransitioning.swift
//  shortNewIOS
//
//  Created by SSd on 12/17/16.
//  Copyright © 2016 SSd. All rights reserved.
//

import Foundation
import UIKit

class AnimatedTransitioning : NSObject , UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let inView  = transitionContext.containerView
        let toVC = transitionContext.viewController(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)
        inView.addSubview((toVC?.view)!)
        let screenRect = UIScreen.main.bounds
        toVC?.view.frame = CGRect(x: 0, y: screenRect.size.height, width: screenRect.size.width, height: screenRect.size.height)
        UIView.animate(withDuration: 0.25, animations: {
            toVC?.view.frame = CGRect(x: 0, y: 0, width:(fromVC?.view.frame.size.width)! , height: (fromVC?.view.frame.size.height)!)
        }) { (Bool) in
            transitionContext.completeTransition(true)
        }
    }
  
}
