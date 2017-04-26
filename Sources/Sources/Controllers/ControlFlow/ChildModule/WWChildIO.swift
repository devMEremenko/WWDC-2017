//
//  WWChildIO.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

protocol WWChildInput : class {
    
}

protocol WWChildOutput : class {
    
    func animatePlane(completion: CodeBlock)
    func animatedFinalScene(completion: CodeBlock?)
    func dissmissAnimatedViews(completion: CodeBlock?)
}
