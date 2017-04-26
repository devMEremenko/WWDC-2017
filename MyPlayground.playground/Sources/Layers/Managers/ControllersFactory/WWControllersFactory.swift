//
//  WWControllersFactory.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWControllersFactory: NSObject {
    
    static func controllerBy(type: WWSceneType) -> WWChildVC {
        
        switch type {
        case .Intro:
            return WWIntroVC()
        case .Dream:
            return WWDreamVC()
        case .Username:
            return WWUsernameVC()
        case .Alarm:
            return WWAlarmVC()
        case .Technologies:
            return WWTechnologiesVC()
        case .Exam:
            return WWExamVC()
        case .Trip:
            return WWTripVC()
        case .Final:
            return WWFinalVC()
        case .Profile:
            return WWProfileVC()
            
        default: return WWChildVC()
        }
    }
}
