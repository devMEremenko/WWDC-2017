//
//  WWActionButton.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWActionButton: UIButton {
    
    internal var actionBlock : CodeBlock
    var animationDelay : TimeInterval = 0.0
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func updateWith(actionBlock: CodeBlock) {
        self.actionBlock = actionBlock
    }
}

extension WWActionButton {
    
    func updateToNormalState() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = WWColorTheme.clearBlue().cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.regular(size: 17)
        self.setTitleColor(WWColorTheme.brightBlue(), for: .normal)
    }
    
    func updateToVisibleState() {
        self.alpha = 1
        self.isUserInteractionEnabled = true
    }
    
    func updateToHiddenState() {
        self.isUserInteractionEnabled = false
        self.alpha = 0
    }
    
    func updateToCircle(withSide: CGFloat) {
        self.layer.cornerRadius = withSide / 2
        self.layer.masksToBounds = true
    }
}

extension WWActionButton {
    
    func updateScaleAnimationTo(visibleState: Bool) {
        
        DispatchBlockToMainQueue {
            
            if visibleState {
                UIView.animateKeyframes(withDuration: 0.95,
                                        delay: self.animationDelay,
                                        options: [.autoreverse, .repeat, .allowUserInteraction],
                                        animations: {
                                            self.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
                }, completion: nil)
            }
            else {
                self.layer.removeAllAnimations()
            }
        }
    }
}


private extension WWActionButton {
    
    @objc func actionSelected() {
        self.actionBlock?()
    }
}

private extension WWActionButton {
    
    func configureViews() {
        self.addTarget(self, action: #selector(self.actionSelected), for: .touchUpInside)
    }
}
