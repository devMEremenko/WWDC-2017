//
//  WWTripVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWTripVC: WWChildVC {
    
    internal let contentView = WWTripView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.updateWith {
            WWSceneRouter.current.presentScreenWith(sceneType: .Final)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchBlockToMainQueue {
            self.contentView.startAnimation()
        }
    }
}


private extension WWTripVC {
    
}
