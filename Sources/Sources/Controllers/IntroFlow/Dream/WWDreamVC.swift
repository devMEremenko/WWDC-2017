//
//  WWDreamVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWDreamVC: WWChildVC {

    let contentView = WWDreamView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.updateWith { 
            WWSceneRouter.current.presentScreenWith(sceneType: .Username)
        }
    }
}
