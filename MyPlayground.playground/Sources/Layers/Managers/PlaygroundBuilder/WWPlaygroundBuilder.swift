//
//  WWPlaygroundBuilder.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWPlaygroundConstants {
    static let screenFrame = CGRect(origin: .zero, size: kScreenSize())
}

public class WWPlaygroundBuilder: NSObject {
    
    public static func createInteractiveScene() -> UIWindow {
        
        UIFont.setupFonts()
        
        let containerController = WWContainerVC()
        let router = WWSceneRouter.current
        router.updateWith(parentController: containerController)
        router.presentScreenWith(sceneType: .Intro)
        
        let window = UIWindow(frame: WWPlaygroundConstants.screenFrame)
        window.rootViewController = router.parentController
        window.makeKeyAndVisible()
        
        return window
    }
}
