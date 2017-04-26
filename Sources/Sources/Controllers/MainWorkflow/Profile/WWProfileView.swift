//
//  WWProfileView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWProfileViewConstants {
    static let contentSize = CGSize(width: kScreenWidth(), height: 1260)
}

class WWProfileView: WWChildView {
    
    let scrollView = WWScrollView(contentSize: WWProfileViewConstants.contentSize)
    let profileContentView = WWProfileContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func update(numberOfPages: Int) {
        self.profileContentView.update(numberOfPages: numberOfPages)
    }
    
    func update(currentPage: Int) {
        self.profileContentView.update(currentPage: currentPage)
    }
    
    func collectionView() -> UICollectionView? {
        return self.profileContentView.collectionView
    }
    
    func updateWith(againBlock: CodeBlock) {
        self.profileContentView.updateWith(againBlock: againBlock)
    }
}

private extension WWProfileView {
    
    func configureViews() {
        
        self.backgroundColor = WWColorTheme.whiteApp()
        self.addSubview(scrollView)
        
        let insets = UIEdgeInsetsMake(1, 0, 0, 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.snp.makeConstraints { (make: ConstraintMaker) in
            make.edges.equalTo(self).inset(insets)
        }
        
        self.scrollView.contentView.addSubview(profileContentView)
        
        profileContentView.snp.makeConstraints { (make: ConstraintMaker) in
            make.edges.equalTo(self.scrollView.contentView)
        }
    }
}
