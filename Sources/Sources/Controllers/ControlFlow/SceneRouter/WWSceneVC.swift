//
//  WWSceneVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

public class WWSceneVC: UIViewController, WWSceneIO, WWChildOutput {
    
    internal func dissmissAnimatedViews(completion: CodeBlock?) {
        
    }

    internal func animatedFinalScene(completion: CodeBlock?) {
        
    }

    internal func animatePlane(completion: CodeBlock) {
        
    }
    
    public var sceneType: WWSceneType?
    weak var currentChild : WWChildVC?
    
    public func childFrame() -> CGRect {
        return .zero
    }
}
