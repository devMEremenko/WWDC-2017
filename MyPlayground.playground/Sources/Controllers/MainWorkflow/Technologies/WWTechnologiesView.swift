//
//  WWTechnologiesView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWTechnologiesView: WWChildView {
    
    let titleLabel = UILabel()
    let resultLabel = UILabel()

    let iconsContentView = WWTechnologiesContainerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    override func updateWith(nextBlock: CodeBlock) {
        super.updateWith(nextBlock: nextBlock)
        self.iconsContentView.updateWith(nextBlock: nextBlock)
    }
    
    func showResults() {
        DispatchBlockToMainQueue { 
            UIView.animate(withDuration: 0.4) {
                self.resultLabel.alpha = 1
            }
        }
    }
}


private extension WWTechnologiesView {
    
    func configureViews() {
        
        self.backgroundColor = WWColorTheme.whiteApp()
        
        self.addSubview(titleLabel)
        self.addSubview(iconsContentView)
        self.addSubview(resultLabel)
        
        let insets = UIEdgeInsetsMake(34, 0, 0, 0)
        titleLabel.text = NSLocalizedString("tech.title.label.text", comment: "")
        titleLabel.updateTheme()
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self).inset(insets)
            make.height.equalTo(84)
        }
        
        let contentInsets = UIEdgeInsetsMake(30, 0, 0, 0)
        iconsContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(contentInsets)
        }
        
        let resultInsets = UIEdgeInsetsMake(0, 10, 34, 0)
        resultLabel.text = NSLocalizedString("tech.results.label.text", comment: "")
        resultLabel.updateTheme()
        resultLabel.alpha = 0
        resultLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.bottom.equalTo(self).inset(resultInsets)
            make.height.equalTo(26)
        }
    }
}
