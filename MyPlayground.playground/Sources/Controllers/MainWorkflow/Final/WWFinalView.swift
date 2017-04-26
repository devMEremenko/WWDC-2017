//
//  WWFinalView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

enum WWFinalConstants {
    static let planeSize = CGSize(width: 74, height: 34)
    static let startPoint = CGPoint(x: -60, y: 46)
    static let planeAnimationDuration = 7.4
    static let completionDuration = WWFinalConstants.planeAnimationDuration - 3.5
    static let sceneAnimationDuration = 1.8
    static let actionDuration = 0.6
    static let dismissDuration = 0.3
    static let dismissScenePoint = CGPoint(x: 0 - kScreenWidth() / 2,
                                           y: WWContainerConstants.collectionSize.height / 2)
}

class WWFinalView: WWChildView {
    
    let infoLabel = UILabel()
    let profileButton = WWActionButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
}


extension WWFinalView {
    
    func updateContentToVisibleState() {
        DispatchBlockToMainQueue {
            
            UIView.animate(withDuration: WWFinalConstants.actionDuration,
                           animations: {
                            self.infoLabel.alpha = 1
                            self.profileButton.alpha = 1
            }, completion: { (finished) in
                self.profileButton.updateToVisibleState()
                self.profileButton.updateToNormalState()
            })
        }
    }
}


private extension WWFinalView {
    
    func configureViews() {
        
        self.backgroundColor = WWColorTheme.whiteApp()
        self.addSubview(profileButton)
        self.addSubview(infoLabel)
        
        let infoInsets = UIEdgeInsetsMake(30, 35, 0, 35)
        infoLabel.updateTheme()
        infoLabel.alpha = 0
        infoLabel.text = NSLocalizedString("final.info.label.title", comment: "")
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.left.right.equalTo(self).inset(infoInsets)
            make.height.equalTo(220)
        }
        
        let title = NSLocalizedString("final.profile.button.title", comment: "")
        profileButton.setTitle(title, for: .normal)
        profileButton.updateToNormalState()
        profileButton.updateToHiddenState()
        profileButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self.infoLabel.snp.bottom).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        profileButton.updateWith {
            self.nextSelected()
        }
    }
}
