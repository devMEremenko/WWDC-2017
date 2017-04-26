//
//  WWLetterView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWLetterView: WWChildView {
    
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let planeImageView = UIImageView()
    let actionButton = WWActionButton()
    let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
}

private extension WWLetterView {
    
    func configureViews() {
        self.backgroundColor = UIColor.clear
        
        self.addSubview(contentView)
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(actionButton)
        self.contentView.addSubview(logoImageView)
        self.contentView.addSubview(planeImageView)
        self.contentView.addSubview(titleLabel)

        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        let contentInsets = UIEdgeInsetsMake(60, 0, -40, 0)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(contentInsets)
        }
        
        let title = NSLocalizedString("letter.action.button.title", comment: "")
        actionButton.setTitle(title, for: .normal)
        actionButton.updateToNormalState()
        actionButton.updateWith { 
            self.nextSelected()
        }
        actionButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(0 - contentInsets.top - 35)
            make.height.equalTo(36)
            make.width.equalTo(107)
        }
        
        logoImageView.image = UIImage(named: "letter_apple_logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(30)
            make.height.equalTo(37)
            make.top.equalTo(self.contentView.snp.top).offset(32)
        }
        
        if let username = WWMemoryDataManager.shared.currentUsername() {
            let prefix = NSLocalizedString("letter.title.prefix", comment: "")
            titleLabel.text = prefix + " " + username.capitalized + ","
        }
        
        titleLabel.updateTheme()
        titleLabel.font = UIFont.semibold(size: 17)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.top.equalTo(self.logoImageView.snp.bottom).offset(34)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(24)
        }
        
        infoLabel.text = NSLocalizedString("letter.info.label.title", comment: "")
        infoLabel.updateTheme()
        let infoInsets = UIEdgeInsetsMake(0, 40, 0, 40)
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(28)
            make.left.right.equalTo(self.contentView).inset(infoInsets)
            make.height.equalTo(208)
        }
        
        planeImageView.image = UIImage(named: "plane")
        planeImageView.contentMode = .scaleAspectFit
        planeImageView.snp.makeConstraints { (make: ConstraintMaker) in
            make.height.equalTo(45)
            make.width.equalTo(98)
            make.right.equalTo(self.contentView).offset(-70)
            make.top.equalTo(self.infoLabel.snp.bottom).offset(40)
        }
    }
}
