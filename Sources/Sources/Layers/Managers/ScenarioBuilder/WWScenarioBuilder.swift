//
//  WWScenarioBuilder.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWScenarioBuilder: NSObject {
    
    static func createScenario() -> WWScenarioDomainModel {
        let scenarioModel = WWScenarioDomainModel()
        
        var scenes = [WWSceneDomainModel]()
        for type in 0...WWSceneType.Count.rawValue {
            scenes.append(sceneFor(type: WWSceneType(rawValue: type)!))
        }
        scenarioModel.scenesModels = scenes
        
        return scenarioModel
    }
    
    static func sceneFor(type: WWSceneType) -> WWSceneDomainModel {
        
        let model = WWSceneDomainModel()
        model.sceneImage = sceneImageFor(type: type)
        model.sceneType = type
        
        return model
    }
    
    private static func sceneImageFor(type: WWSceneType) -> UIImage? {
        
        var image : UIImage?
        
        switch type {
        case .Intro:
            image = UIImage(named: "intro_header")
            break
        case .Dream:
            image = UIImage(named: "dream_header")
            break
        case .Username:
            image = UIImage(named: "username_header")
            break
        case .Alarm:
            image = UIImage(named: "alarm_header")
            break
        case .Technologies:
            image = UIImage(named: "technologies_header")
            break
        case .Exam:
            image = UIImage(named: "exam_header")
            break
        case .Trip:
            image = UIImage(named: "trip_header")
            break
        case .Final:
            image = UIImage(named: "final_header")
            break
        case .Profile:
            image = UIImage(named: "profile_header")
            break
        default: break
        }
        
        return image
    }
}
