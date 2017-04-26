//
//  WWContainerAnimationContentView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/1/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWContainerAnimationContentView: UIView {
    
    let animator = WWPlaneAnimator()
    
    let planeImageView = UIImageView()
    let finalImageView = UIImageView()
}

internal extension WWContainerAnimationContentView {
    
    func animatePlane(completion: CodeBlock) {
        
        if planeImageView.superview == nil {
            self.addSubview(planeImageView)
            planeImageView.image = UIImage(named: "plane")
        }
        
        self.bringSubview(toFront: planeImageView)
        
        let size = WWFinalConstants.planeSize
        let origin = WWFinalConstants.startPoint
        planeImageView.frame = CGRect(origin: origin, size: size)
        
        let startPoint = WWFinalConstants.startPoint
        animator.animate(view: planeImageView,
                         startPoint: startPoint,
                         duration: WWFinalConstants.planeAnimationDuration)
        
        DispatchBlockAfter(delay: WWFinalConstants.completionDuration) {
            completion?()
        }
    }
    
    func animatedFinalScene(completion: CodeBlock?) {
        
        if finalImageView.superview == nil {
            self.addSubview(finalImageView)
            finalImageView.image = UIImage(named: "final_header_2")
        }
        
        self.bringSubview(toFront: finalImageView)
        
        let startFrame = CGRect(origin: WWContainerConstants.childFrame.origin,
                                size: WWContainerConstants.collectionSize)
        let endFrame = CGRect(origin: .zero, size: WWContainerConstants.collectionSize)
        
        finalImageView.frame = startFrame
        
        DispatchBlockToMainQueue { 
            UIView.animate(withDuration: WWFinalConstants.sceneAnimationDuration,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0.1,
                           options: .curveEaseOut,
                           animations: {
                            self.finalImageView.frame = endFrame
            }) { (finished) in
                completion??()
            }
        }
    }
    
    func dissmissAnimatedViews(completion: CodeBlock?) {
        
        DispatchBlockToMainQueue { 
            
            UIView.animate(withDuration: WWFinalConstants.dismissDuration,
                           animations: {
                            self.finalImageView.center = WWFinalConstants.dismissScenePoint
            }) { (finished) in
                self.finalImageView.removeFromSuperview()
                self.planeImageView.removeFromSuperview()
                completion??()
            }
        }
    }
}
