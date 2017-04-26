//
//  WWIntroView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWIntroView: WWChildView {
    
    var titleImageView = UIImageView()
    var infoLabel = UILabel()
    var actionButton = WWActionButton()
    var emojiImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
}


private extension WWIntroView {
    
    func configureViews() {
        self.backgroundColor = WWColorTheme.whiteApp()
        
        self.addSubview(titleImageView)
        self.addSubview(infoLabel)
        self.addSubview(actionButton)
        self.addSubview(emojiImageView)
        
        let titleImageViewInsests = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        titleImageView.image = UIImage(named: "intro_wwdc")
        titleImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).inset(titleImageViewInsests)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(WWIntroContants.titleImageViewSize.width)
            make.height.equalTo(WWIntroContants.titleImageViewSize.height)
        }
        
        infoLabel.text = NSLocalizedString("intro.info.label.text", comment: "")
        infoLabel.updateTheme()
        
        let insests = UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleImageView.snp.bottom).offset(50)
            make.left.right.equalTo(self).inset(insests)
            make.height.equalTo(100)
        }
        
        let actionTitle = NSLocalizedString("intro.action.button.title", comment: "")
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.updateToNormalState()
        actionButton.updateWith { 
            self.nextSelected()
        }
        actionButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.infoLabel.snp.bottom).offset(68)
            make.height.equalTo(36)
            make.width.equalTo(150)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        emojiImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.actionButton.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(60)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}
