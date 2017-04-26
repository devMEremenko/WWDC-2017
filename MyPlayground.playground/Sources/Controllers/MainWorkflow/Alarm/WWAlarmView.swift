//
//  WWAlarmView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit
import SpriteKit

class WWAlarmView: WWChildView {
    
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    var sceneView = SKView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
}

extension WWAlarmView {
    
    func connectBubbles() {
        let magneticScene = Magnetic(size: WWAlarmConstants.sceneSize)
        magneticScene.backgroundColor = WWColorTheme.whiteApp()
        sceneView.presentScene(magneticScene)
    
        let bubbles = WWBubbleBuilder.bubbles()
        for node in bubbles {
            magneticScene.addChild(node)
            node.updateWith(actionBlock: {
                self.checkNodeSelection()
            })
        }
    }
    
    func checkNodeSelection() {
        
        if isAlarmsSelected() {
            updateNodeTitles()
            DispatchBlockAfter(delay: 0.95, block: {
                WWSceneRouter.current.presentScreenWith(sceneType: .Technologies)
            })
        }
    }
    
    func isAlarmsSelected() -> Bool {
        
        guard let children = sceneView.scene?.children else {
            return false
        }
        
        var allSelected = true
        
        for node in children {
            if node is WWBubbleNode {
                let node = node as! WWBubbleNode
                
                if node.type == .Alarm && !node.selected {
                    allSelected = false
                }
                
                // it is for safety :)
                if node.type == nil {
                    allSelected = false
                }
            }
        }
        
        return allSelected
    }
    
    func updateNodeTitles() {
        
        guard let children = sceneView.scene?.children else {
            return
        }
        
        for node in children {
            if node is WWBubbleNode {
                let node = node as! WWBubbleNode
                node.title = NSLocalizedString("exam.success.answer.title", comment: "")
            }
        }
    }
}


private extension WWAlarmView {
    
    func configureViews() {
        
        self.backgroundColor = WWColorTheme.whiteApp()
        self.addSubview(titleLabel)
        self.addSubview(infoLabel)
        self.addSubview(sceneView)
        
        let titleInsets = UIEdgeInsetsMake(22, 20, 0, 20)
        let titlePrefix = NSLocalizedString("alarm.title.prefix", comment: "")
        let titleSufix = NSLocalizedString("alarm.title.sufix", comment: "")
        if let username = WWMemoryDataManager.shared.username {
            titleLabel.text = titlePrefix + ", " + username.capitalized + "!" + "\n" + titleSufix
        }
        titleLabel.updateTheme()
        titleLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.left.right.equalTo(self).inset(titleInsets)
            make.height.equalTo(48)
        }
        
        infoLabel.updateTheme()
        infoLabel.text = NSLocalizedString("alarm.info.label.title", comment: "")
        infoLabel.textColor = WWColorTheme.warmGrey()
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.equalTo(self).inset(titleInsets)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            make.height.equalTo(24)
        }
        
        sceneView.backgroundColor = SKColor.red
        sceneView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(WWAlarmConstants.sceneHeight)
        }
    }
}
