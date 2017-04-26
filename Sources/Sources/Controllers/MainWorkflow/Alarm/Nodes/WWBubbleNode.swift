//
//  WWBubbleNode.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit
import SpriteKit

enum WWBubleType : Int {
    case Alarm
    case Radio
    case Door
    case Count
}

class WWBubbleNode: Node {
    
    var type : WWBubleType?
    internal var actionBlock : ((()->Void)?)
    
    func updateWith(actionBlock: CodeBlock) {
        self.actionBlock = actionBlock
    }
    
    override var selected: Bool {
        
        didSet {
            if selected {
                self.actionBlock?()
            }
        }
    }
}
