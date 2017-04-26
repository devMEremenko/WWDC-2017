//
//  WWContainerView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

public class WWContainerView: UIView {
    
    internal var collectionView : UICollectionView?
    let animationContentView = WWContainerAnimationContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
}


extension WWContainerView {
    
    func attachChild(view: UIView) {
        view.frame = WWContainerConstants.childFrame
        self.addSubview(view)
    }
}


private extension WWContainerView {
    
    func configureViews() {
        self.backgroundColor = WWColorTheme.whiteApp()
        self.attachCollection()
        self.attachAnimationView()
    }
    
    func attachAnimationView() {
        self.addSubview(animationContentView)
        animationContentView.snp.makeConstraints { (make: ConstraintMaker) in
            make.edges.equalTo((self.collectionView?.snp.edges)!)
        }
    }
    
    func attachCollection() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout())
        self.collectionView?.backgroundColor = WWColorTheme.whiteApp()
        self.collectionView?.isPagingEnabled = false
        self.collectionView?.isScrollEnabled = false
        
        self.addSubview(self.collectionView!)
        
        self.collectionView?.snp.makeConstraints({ (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(WWContainerConstants.collectionSize.height)
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

internal extension WWContainerView {
    
    func animatePlane(completion: CodeBlock) {
        animationContentView.animatePlane(completion: completion)
    }
    
    func animatedFinalScene(completion: CodeBlock?) {
        animationContentView.animatedFinalScene(completion: completion)
    }
    
    func dissmissAnimatedViews(completion: CodeBlock?) {
        animationContentView.dissmissAnimatedViews(completion: completion)
    }
}
