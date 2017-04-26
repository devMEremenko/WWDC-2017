//
//  WWBubbleView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/2/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWBubbleView: UIView {
    
    func updateToNormalTheme() {
        self.layer.cornerRadius = WWTechnologiesConstaints.bubbleSide / 2
        self.layer.masksToBounds = true
    }
    
    func updateToVisibleState() {
        self.backgroundColor = WWColorTheme.skyBlue()
    }
    
    func updateToHiddenState() {
        self.backgroundColor = UIColor.clear
    }
}
