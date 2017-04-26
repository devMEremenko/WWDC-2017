//
//  WWProfileVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWProfileVC: WWChildVC {
    
    let contentView = WWProfileView()
    let controller = WWProfileController()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureModule()
    }
}

private extension WWProfileVC {
    
    func configureModule() {
        
        let models = WWProfileBuilder.createModels()
        self.controller.attach(collectionView: self.contentView.collectionView())
        self.controller.updateWith(models: models)
        self.controller.updateWith { (page: Int) in
            self.contentView.update(currentPage: page)
        }
        
        self.contentView.update(numberOfPages: models.count)
        self.contentView.updateWith(againBlock: { 
            WWSceneRouter.current.presentScreenWith(sceneType: .Intro)
        })
    }
}
