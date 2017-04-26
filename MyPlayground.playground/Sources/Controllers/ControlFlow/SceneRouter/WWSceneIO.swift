//
//  WWSceneIO.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWAnimation {
    static let transitionDuration = 0.7
}

public enum WWSceneType : Int {
    case Intro
    case Dream
    case Username
    case Alarm
    case Technologies
    case Exam
    case Trip
    case Final
    case Profile
    case Count
}

public protocol WWSceneIO : class {

    var sceneType: WWSceneType? { get set }
    
    func childFrame() -> CGRect
}
