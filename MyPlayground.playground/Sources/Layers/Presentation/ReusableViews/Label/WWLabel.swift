//
//  WWLabel.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

public extension UILabel {
    
    func updateTheme() {
        self.numberOfLines = 0
        self.font = UIFont.regular(size: 17)
        self.textColor = WWColorTheme.blackApp()
        self.textAlignment = .center
    }
}
