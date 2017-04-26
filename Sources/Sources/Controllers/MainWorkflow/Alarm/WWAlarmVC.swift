//
//  WWAlarmVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWAlarmVC: WWChildVC {
    
    let contentView = WWAlarmView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.connectBubbles()
        self.contentView.updateWith {
            WWSceneRouter.current.presentScreenWith(sceneType: .Technologies)
        }
    }
}
