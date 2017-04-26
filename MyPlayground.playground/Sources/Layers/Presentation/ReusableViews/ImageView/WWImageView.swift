//
//  WWImageView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/1/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func updateToAvatarTheme(side: CGFloat) {
        
        let cornerRadius = side / 2
        self.layer.cornerRadius = CGFloat(ceilf(Float(cornerRadius)))
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
