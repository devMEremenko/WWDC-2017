//
//  WWExamBuilder.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

enum WWExamType : Int {
    case Json
    case Ruby
    case ObjectiveC
    case Swift
    case Count
}

class WWExamBuilder: NSObject {
    
    static func titleFor(result: WWExamResult) -> String {
        
        var title = ""
        if result == .Fail {
            title = NSLocalizedString("exam.fail.answer.title", comment: "")
        }
        else if result == .Success {
            title = NSLocalizedString("exam.success.answer.title", comment: "")
        }
        
        return title
    }
    
    static func createExamModels() -> [WWPhotoDomainModel] {
        
        var models = [WWPhotoDomainModel]()
        
        for counter in 0 ..< WWExamType.Count.rawValue {
            let type = WWExamType(rawValue: counter)
            models.append(examModelForType(type: type!))
        }
        
        return models
    }
    
    static func examModelForType(type: WWExamType) -> WWPhotoDomainModel {
        
        let model = WWPhotoDomainModel()
        
        switch type {
        case .Swift:
            model.image = UIImage(named: "exam_swift")
            break
        case .Json:
            model.image = UIImage(named: "exam_json")
            break
        case .ObjectiveC:
            model.image = UIImage(named: "exam_objc")
            break
        case .Ruby:
            model.image = UIImage(named: "exam_ruby")
            break
        default: break
        }
        return model
    }
}
