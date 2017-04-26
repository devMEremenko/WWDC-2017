//
//  WWHelperFunctions.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

func kScreenHeight() -> CGFloat {
    return kScreenSize().height
}

func kScreenWidth() -> CGFloat {
    return kScreenSize().width
}

func kScreenSize() -> CGSize {
    return CGSize(width: 375, height: 667)
}


typealias CodeBlock = ((()->Void)?)

func DispatchBlockToMainQueue(block: CodeBlock) {
    
    if Thread.isMainThread {
        block?()
    } else {
        DispatchQueue.main.async {
            block?()
        }
    }
}

func DispatchBlockAfter(delay: Double, block: CodeBlock) {
    
    let deadline = DispatchTime.now() + delay
    
    DispatchQueue.main.asyncAfter(deadline: deadline) {
        DispatchBlockToMainQueue(block: block)
    }
}
