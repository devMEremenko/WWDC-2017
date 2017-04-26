//
//  WWTechnologiesContainerView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/2/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWTechnologiesConstaints {
    static let itemSize = CGSize(width: 94, height: 94)
    static let bubbleSide : CGFloat = 8
}

class WWTechnologiesContainerView: UIView {
    
    var buttons = [WWActionButton]()
    var nextBlock : CodeBlock
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func updateWith(nextBlock: CodeBlock) {
        self.nextBlock = nextBlock
    }
}


private extension WWTechnologiesContainerView {
    
    func configureViews() {
        
        let size = WWTechnologiesConstaints.itemSize
        
        let firstActionButton = WWActionButton()
        firstActionButton.frame = CGRect(origin: .zero, size: size)
        firstActionButton.setImage(UIImage(named: "realm_icon"), for: .normal)
        
        let secondActionButton = WWActionButton()
        secondActionButton.frame = CGRect(origin: .zero, size: size)
        secondActionButton.setImage(UIImage(named: "fastlane_icon"), for: .normal)
        
        let thirdActionButton = WWActionButton()
        thirdActionButton.frame = CGRect(origin: .zero, size: size)
        thirdActionButton.setImage(UIImage(named: "firebase_icon"), for: .normal)
        
        let fourthActionButton = WWActionButton()
        fourthActionButton.frame = CGRect(origin: .zero, size: size)
        fourthActionButton.setImage(UIImage(named: "swift_icon"), for: .normal)
        
        buttons = [firstActionButton,
                   secondActionButton,
                   thirdActionButton,
                   fourthActionButton]
        
        var lastView : UIView?
        
        for (index, actionButton) in buttons.enumerated() {
            
            let bubbleView = createBubble()
            
            weak var wBubble = bubbleView
            weak var wButton = actionButton
            weak var welf = self
            
            self.addSubview(actionButton)
            self.addSubview(bubbleView)
            
            actionButton.updateWith(actionBlock: {
                wButton?.isSelected = true
                UIView.animate(withDuration: 0.5, animations: {
                    wBubble?.updateToVisibleState()
                })
                welf?.checkButtonSelection()
            })
            
            actionButton.snp.makeConstraints({ (make: ConstraintMaker) in
                
                make.width.equalTo(size.width)
                make.height.equalTo(size.height)
                make.centerY.equalTo(self.snp.centerY)
                
                if index == 0 {
                    make.left.equalTo(self.snp.left)
                }
                else if let lastView = lastView {
                    make.left.equalTo(lastView.snp.right)
                }
            })
            
            bubbleView.snp.makeConstraints({ (make: ConstraintMaker) in
                make.top.equalTo(actionButton.snp.bottom).offset(8)
                make.width.equalTo(WWTechnologiesConstaints.bubbleSide)
                make.height.equalTo(WWTechnologiesConstaints.bubbleSide)
                make.centerX.equalTo(actionButton.snp.centerX)
            })
            
            lastView = actionButton
        }
    }
    
    func createBubble() -> WWBubbleView {
        
        let view = WWBubbleView()
        view.updateToNormalTheme()
        return view
    }
}

private extension WWTechnologiesContainerView {
    
    func checkButtonSelection() {
        
        if self.isAllButtonsSelected() {
            self.nextBlock?()
        }
    }
    
    func isAllButtonsSelected() -> Bool {
        var isAllSelected = true
        
        for (_, actionButton) in buttons.enumerated() {
            if !actionButton.isSelected {
                isAllSelected = false
                break
            }
        }
        return isAllSelected
    }
}
