//
//  WWIntroVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWIntroVC: WWChildVC {
    
    var contentView = WWIntroView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.updateWith {
            
            WWSceneRouter.current.presentScreenWith(sceneType: .Dream)
        }
    }
}
