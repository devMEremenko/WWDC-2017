//
//  WWUsernameVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWUsernameVC: WWChildVC {
    
    let contentView = WWUsernameView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.updateWith { (username: String) in
            WWMemoryDataManager.shared.update(username: username)
            WWSceneRouter.current.presentScreenWith(sceneType: .Alarm)
        }
    }
}
