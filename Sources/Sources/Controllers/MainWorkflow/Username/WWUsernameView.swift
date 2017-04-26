//
//  WWUsernameView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/2/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

typealias WWUsernameSelectionBlock = (((String)->())?)

struct WWUsernameViewConstants {
    static let buttonSide : CGFloat = 116.0
    static let buttonXOffset : CGFloat = -10.0
    static let buttonYOffset : CGFloat = -6.0
    static let buttonCenterYOffset : CGFloat = 90
}

class WWUsernameView: UIView {
    
    let infoLabel = UILabel()
    var usernameSelectionBlock : WWUsernameSelectionBlock
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func updateWith(usernameSelectionBlock: WWUsernameSelectionBlock) {
        self.usernameSelectionBlock = usernameSelectionBlock
    }
}

private extension WWUsernameView {
    
    func configureViews() {
        self.backgroundColor = WWColorTheme.whiteApp()
        
        let side = WWUsernameViewConstants.buttonSide
        let xOffset = WWUsernameViewConstants.buttonXOffset
        let yOffset = WWUsernameViewConstants.buttonYOffset
        let centerYOffset = WWUsernameViewConstants.buttonCenterYOffset
        
        let leftTitle = NSLocalizedString("username.left.button.title", comment: "")
        let centerTitle = NSLocalizedString("username.center.button.title", comment: "")
        let rightTitle = NSLocalizedString("username.right.button.title", comment: "")
        
        let leftButton = WWActionButton()
        leftButton.animationDelay = 0.5
        leftButton.updateScaleAnimationTo(visibleState: true)
        leftButton.setTitle(leftTitle, for: .normal)
        leftButton.titleLabel?.font = UIFont.semibold(size: 20)
        leftButton.backgroundColor = WWColorTheme.mediumGreen()
        leftButton.updateToCircle(withSide: side)
        leftButton.updateWith {
            self.usernameSelectionBlock?(leftTitle)
        }
        
        let centerButton = WWActionButton()
        centerButton.animationDelay = 1.0
        centerButton.updateScaleAnimationTo(visibleState: true)
        centerButton.setTitle(centerTitle, for: .normal)
        centerButton.titleLabel?.font = UIFont.semibold(size: 20)
        centerButton.backgroundColor = WWColorTheme.marigold()
        centerButton.updateToCircle(withSide: side)
        centerButton.updateWith {
            self.usernameSelectionBlock?(centerTitle)
        }
        
        let rightButton = WWActionButton()
        rightButton.animationDelay = 1.5
        rightButton.updateScaleAnimationTo(visibleState: true)
        rightButton.setTitle(rightTitle, for: .normal)
        rightButton.titleLabel?.font = UIFont.semibold(size: 20)
        rightButton.backgroundColor = WWColorTheme.reddishPink()
        rightButton.updateToCircle(withSide: side)
        rightButton.updateWith {
            self.usernameSelectionBlock?(rightTitle)
        }
        
        self.addSubview(leftButton)
        self.addSubview(centerButton)
        self.addSubview(rightButton)
        self.addSubview(infoLabel)
        
        leftButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.right.equalTo(centerButton.snp.left).offset(-xOffset)
            make.centerY.equalTo(self.snp.centerY).offset(yOffset)
            make.width.height.equalTo(side)
        }
        
        centerButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(centerYOffset)
            make.width.height.equalTo(side)
        }
        
        rightButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.equalTo(centerButton.snp.right).offset(xOffset)
            make.centerY.equalTo(self.snp.centerY).offset(yOffset)
            make.width.height.equalTo(side)
        }
        
        infoLabel.updateTheme()
        infoLabel.text = NSLocalizedString("username.info.label.title", comment: "")
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(34)
            make.height.equalTo(24)
        }
    }
}
