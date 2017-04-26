//
//  WWChildView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWChildView: UIView {
    
    var nextBlock : ((()->Void)?)
    
    func updateWith(nextBlock: CodeBlock) {
        self.nextBlock = nextBlock
    }
    
    internal func nextSelected() {
        self.nextBlock?()
    }
}
