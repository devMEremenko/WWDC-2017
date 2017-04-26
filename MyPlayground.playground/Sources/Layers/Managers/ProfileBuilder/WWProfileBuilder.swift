//
//  WWProfileBuilder.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/1/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWProfileConstants {
    static let numberOfPhotos = 6
}

class WWProfileBuilder: NSObject {
    
    static func createModels() -> [WWPhotoDomainModel] {
        
        var models = [WWPhotoDomainModel]()
        
        for counter in 0 ..< WWProfileConstants.numberOfPhotos {
            let photoName = "profile_photo_" + "\(counter + 1)"
            let photoModel = WWPhotoDomainModel()
            photoModel.image = UIImage(named: photoName)
            models.append(photoModel)
        }
        
        return models
    }
}
