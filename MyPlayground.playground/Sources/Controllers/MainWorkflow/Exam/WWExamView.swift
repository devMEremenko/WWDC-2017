//
//  WWExamView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWExamView: WWChildView {
    
    let actionButton = WWActionButton()
    let infoLabel = UILabel()
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
}

private extension WWExamView {
    
    func configureViews() {
        
        self.backgroundColor = WWColorTheme.whiteApp()
        
        self.addSubview(actionButton)
        self.addSubview(infoLabel)
        self.addSubview(pageControl)
        self.attachCollection()

        let infoInsets = UIEdgeInsetsMake(20, 10, 0, 10)
        
        if let username = WWMemoryDataManager.shared.username {
            let sufix = NSLocalizedString("exam.info.label.title", comment: "")
            infoLabel.text = username.capitalized + ", " + sufix
        }

        infoLabel.updateTheme()
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.left.right.equalTo(self).inset(infoInsets)
            make.height.equalTo(48)
        }
        
        actionButton.updateWith { 
            self.nextSelected()
        }
        let title = NSLocalizedString("exam.action.button.title", comment: "")
        actionButton.setTitle(title, for: .normal)
        actionButton.updateToNormalState()
        actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 28, 0))
            make.width.equalTo(184)
            make.height.equalTo(36)
            make.centerX.equalTo(self.snp.centerX)
        }
        
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
        self.collectionView?.backgroundColor = WWColorTheme.grayCode()
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.isScrollEnabled = true
        
        self.addSubview(self.collectionView!)
        
        self.collectionView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.infoLabel.snp.bottom).offset(25)
            make.height.equalTo(216)
        })
    }
    
    func layout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = WWContainerConstants.collectionSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
