//
//  WWDreamView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWDreamView: WWChildView {
    
    let infoLabel = UILabel()
    let actionButton = WWActionButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
}

private extension WWDreamView {
    
    func configureViews() {
        self.addSubview(infoLabel)
        self.addSubview(actionButton)
        
        actionButton.updateWith {
            self.nextSelected()
        }
        let title = NSLocalizedString("dream.action.button.title", comment: "")
        actionButton.setTitle(title, for: .normal)
        actionButton.updateToNormalState()
        actionButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.infoLabel.snp.bottom).offset(66)
            make.width.equalTo(150)
            make.height.equalTo(36)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let infoInsets = UIEdgeInsetsMake(70, 34, 0, 34)
        infoLabel.text = NSLocalizedString("dream.info.label.title", comment: "")
        infoLabel.updateTheme()
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.left.right.equalTo(self).inset(infoInsets)
            make.height.equalTo(160)
        }
    }
}
