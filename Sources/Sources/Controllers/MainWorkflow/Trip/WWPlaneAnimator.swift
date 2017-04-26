//
//  WWPlaneAnimator.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWPlaneConstants {
    static let curveCount = 6
    static let curveOffset = 4
}

class WWPlaneAnimator: NSObject {
    
    func animate(view: UIView,
                 startPoint: CGPoint,
                 duration: Double) {
        
        DispatchBlockToMainQueue {
            
            let values = self.path(with: startPoint, viewSize: view.bounds.size)
            
            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.duration = duration
            animation.values = [0, 0.1, 0.2, 0.2, 1]
            animation.calculationMode = kCAAnimationPaced
            animation.path = values.0.cgPath
            view.layer.add(animation, forKey: "")
            view.center = values.1
        }
    }
    
    func path(with startPoint: CGPoint, viewSize: CGSize) -> (UIBezierPath, CGPoint) {
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        
        var lastPoint = startPoint
        let length = (kScreenWidth() + viewSize.width) / CGFloat(WWPlaneConstants.curveCount)
        
        for index in 0...WWPlaneConstants.curveCount {
            
            var nextPoint = CGPoint(x: CGFloat(index) * length, y: startPoint.y)
            
            if index % 2 == 1 {
                nextPoint.y += CGFloat(WWPlaneConstants.curveOffset)
            } else {
                nextPoint.y -= CGFloat(WWPlaneConstants.curveOffset)
            }
            
            path.addCurve(to: nextPoint, controlPoint1: nextPoint, controlPoint2: nextPoint)
            
            lastPoint = nextPoint
        }
        return (path, lastPoint)
    }
}
