//
//  WWTechnologiesVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWTechnologiesVC: WWChildVC {
    
    let contentView = WWTechnologiesView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var welf = self
        self.contentView.updateWith {
            welf?.contentView.showResults()
            DispatchBlockAfter(delay: 1.5, block: {
                WWSceneRouter.current.presentScreenWith(sceneType: .Exam)
            })
        }
    }
}
