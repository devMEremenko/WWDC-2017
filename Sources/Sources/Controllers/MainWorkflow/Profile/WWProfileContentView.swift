//
//  WWProfileContentView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/1/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWProfileContentViewConstants {
    static let avatarSide = 66
    static let collectionHeight = 260
    static let itemSize = CGSize(width: 200, height: WWProfileContentViewConstants.collectionHeight)
}

class WWProfileContentView: UIView {
    
    let userImageView = UIImageView()
    let usernameLabel = UILabel()
    let infoLabel = UILabel()
    let infoMiddleLabel = UILabel()
    let againButton = WWActionButton()
    var againBlock : ((()->Void)?)
    let pageControl = UIPageControl()
    var collectionView : UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func update(numberOfPages: Int) {
        DispatchBlockToMainQueue {
            self.pageControl.numberOfPages = numberOfPages
        }
    }
    
    func update(currentPage: Int) {
        DispatchBlockToMainQueue {
            self.pageControl.currentPage = currentPage
        }
    }
    
    func updateWith(againBlock: CodeBlock) {
        self.againBlock = againBlock
    }
}

private extension WWProfileContentView {
    
    func configureViews() {
        
        self.backgroundColor = WWColorTheme.whiteApp()
        
        self.addSubview(userImageView)
        self.addSubview(usernameLabel)
        self.addSubview(infoLabel)
        self.addSubview(infoMiddleLabel)
        self.addSubview(againButton)
        self.addSubview(pageControl)
        
        let avatarSide = WWProfileContentViewConstants.avatarSide
        userImageView.image = UIImage(named: "profile_avatar")
        userImageView.updateToAvatarTheme(side: CGFloat(avatarSide))
        userImageView.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self).offset(24)
            make.width.equalTo(avatarSide)
            make.height.equalTo(avatarSide)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let insets = UIEdgeInsetsMake(0, 26, 0, 30)
        usernameLabel.text = NSLocalizedString("profile.username.label.title", comment: "")
        usernameLabel.updateTheme()
        usernameLabel.font = UIFont.semibold(size: 17)
        usernameLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.userImageView.snp.bottom).offset(20)
            make.left.right.equalTo(self).inset(insets)
            make.height.equalTo(24)
        }
        
        infoLabel.text = NSLocalizedString("profile.info.label.title", comment: "")
        infoLabel.updateTheme()
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(14)
            make.left.right.equalTo(self).inset(insets)
            make.height.equalTo(240)
        }
        
        self.attachCollection()
        self.attachPageControl()
        
        let infoMiddleInsets = UIEdgeInsetsMake(0, 32, 0, 32)
        infoMiddleLabel.text = NSLocalizedString("profile.middle.info.label.title", comment: "")
        infoMiddleLabel.updateTheme()
        infoMiddleLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(self.pageControl.snp.bottom).offset(30)
            make.left.right.equalTo(self).inset(infoMiddleInsets)
            make.height.equalTo(440)
        }
        
        let againTitle = NSLocalizedString("profile.again.button.title", comment: "")
        againButton.setTitle(againTitle, for: .normal)
        againButton.updateToNormalState()
        againButton.updateWith {
            self.againBlock?()
        }
        againButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.infoMiddleLabel.snp.bottom).offset(35)
            make.width.equalTo(108)
            make.height.equalTo(36)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}


private extension WWProfileContentView {
    
    func attachPageControl() {
        let pageInsets = UIEdgeInsetsMake(0, 40, 0, 40)
        pageControl.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.equalTo(self).inset(pageInsets)
            make.height.equalTo(8)
            make.top.equalTo((self.collectionView?.snp.bottom)!).offset(13)
        }
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = WWColorTheme.clearBlue()
        pageControl.pageIndicatorTintColor = WWColorTheme.whiteTwo()
    }
    
    func attachCollection() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        self.collectionView?.backgroundColor = WWColorTheme.whiteApp()
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.isPagingEnabled = false
        self.collectionView?.isScrollEnabled = true
        
        self.addSubview(self.collectionView!)
        
        self.collectionView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.infoLabel.snp.bottom).offset(20)
            make.height.equalTo(WWProfileContentViewConstants.collectionHeight)
        })
    }
    
    func layout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = WWProfileContentViewConstants.itemSize
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
