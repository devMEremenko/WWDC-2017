//
//  WWFinalVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWFinalVC: WWChildVC {
    
    let contentView = WWFinalView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.updateWith(nextBlock: {
            self.parentEventHandler?.dissmissAnimatedViews(completion: nil)
            WWSceneRouter.current.presentScreenWith(sceneType: .Profile)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let parent = self.parentEventHandler else {
            return
        }
        parent.animatePlane(completion: {
            parent.animatedFinalScene(completion: { 
                self.contentView.updateContentToVisibleState()
            })
        })
    }
}
