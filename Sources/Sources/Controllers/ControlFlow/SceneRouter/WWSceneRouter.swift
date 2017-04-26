//
//  WWSceneRouter.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWSceneRouter: NSObject {
    
    static let current = WWSceneRouter()
    
    weak var parentController: WWSceneVC?
    
    func updateWith(parentController: WWSceneVC) {
        self.parentController = parentController
    }
    
    func presentScreenWith(sceneType: WWSceneType) {
        
        let updatedChild = WWControllersFactory.controllerBy(type: sceneType)
        updatedChild.parentEventHandler = self.parentController
        
        guard let oldChild = parentController?.currentChild else {
            self.parentController?.sceneType = sceneType
            self.attachChild(child: updatedChild)
            return
        }
        
        self.attachChildAnimated(oldChild: oldChild,
                                 toChild: updatedChild,
                                 sceneType: sceneType)
    }
}

private extension WWSceneRouter {
    
    func attachChild(child: WWChildVC) {
        DispatchBlockToMainQueue {
            
            guard let parentController = self.parentController else {
                return
            }
            
            parentController.addChildViewController(child)
            child.view.frame = parentController.childFrame()
            parentController.view.addSubview(child.view)
            child.didMove(toParentViewController: parentController)
            
            parentController.currentChild = child
        }
    }
    
    func attachChildAnimated(oldChild: WWChildVC, toChild: WWChildVC, sceneType: WWSceneType) {
        
        DispatchBlockToMainQueue {
            
            oldChild.willMove(toParentViewController: nil)
            self.parentController?.addChildViewController(toChild)
            
            toChild.view.frame = (self.parentController?.childFrame())!
            toChild.view.center = self.fromPoint(with: toChild.view)
            
            toChild.view.layoutIfNeeded()
            let oldCenter = oldChild.view.center
            
            self.parentController?.sceneType = sceneType
            
            let duration = WWAnimation.transitionDuration
            self.parentController?.transition(from: oldChild, to: toChild, duration: duration, options: .curveEaseInOut, animations: {
                
                toChild.view.center = oldCenter
                oldChild.view.center = self.toPoint(with: oldChild.view)
                
            }, completion: { finished in
                
                oldChild.removeFromParentViewController()
                toChild.didMove(toParentViewController: self.parentController)
                self.parentController?.currentChild = toChild
            })
        }
    }
}

private extension WWSceneRouter {
    
    func fromPoint(with childView: UIView) -> CGPoint {
        return CGPoint(x: childView.center.x + kScreenWidth(), y: childView.center.y)
    }
    
    func toPoint(with childView: UIView) -> CGPoint {
        return CGPoint(x: childView.center.x - kScreenWidth(), y: childView.center.y)
    }
}
