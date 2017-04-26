//
//  WWContainerController.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWContainerController: NSObject {
    
    internal weak var collectionView : UICollectionView?
    internal var scenarioModel : WWScenarioDomainModel?
    
    func attach(collectionView: UICollectionView) {
        updateWith(collectionView: collectionView)
    }
    
    func updateWith(scenarioModel: WWScenarioDomainModel) {
        self.scenarioModel = scenarioModel
        DispatchBlockToMainQueue { 
            self.collectionView?.reloadData()
        }
    }
    
    func updateWith(sceneType: WWSceneType) {
        let sceneModel = sceneModelFor(sceneType: sceneType)
        updateWith(sceneModel: sceneModel)
    }
}


extension WWContainerController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let scenesModels = self.scenarioModel?.scenesModels else {
            return 0
        }
        
        return scenesModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WWCellIdentifiers.photo, for: indexPath)
        
        if let cell = cell as? WWPhotoCell {
            cell.updateWith(image: sceneModel(at: indexPath).sceneImage)
        }
        
        return cell
    }
}


private extension WWContainerController {
    
    func sceneModel(at indexPath: IndexPath) -> WWSceneDomainModel {
        
        if let models = self.scenarioModel?.scenesModels {
            if indexPath.item < models.count {
                return models[indexPath.item]
            }
        }
        return WWSceneDomainModel()
    }
    
    func sceneModelFor(sceneType: WWSceneType) -> WWSceneDomainModel {
        
        if let models = self.scenarioModel?.scenesModels {
            
            let model = models.filter({ (model) -> Bool in
                return model.sceneType == sceneType
            }).first
            
            if let model = model {
                return model
            }
        }
        return WWSceneDomainModel()
    }
    
    func pageFor(sceneType: WWSceneType) -> Int {
        
        guard let models = self.scenarioModel?.scenesModels else {
            return 0
        }
        
        for (index, model) in models.enumerated() {
            if model.sceneType == sceneType {
                return index
            }
        }
        return 0
    }
}


private extension WWContainerController {
    
    func updateWith(collectionView: UICollectionView) {
        
        DispatchBlockToMainQueue { 
            collectionView.register(WWPhotoCell.self, forCellWithReuseIdentifier: WWCellIdentifiers.photo)
            collectionView.dataSource = self
            
            self.collectionView = collectionView
        }
    }
}


private extension WWContainerController {
    
    func updateWith(sceneModel: WWSceneDomainModel) {
        
        if let sceneType = sceneModel.sceneType {
            let page = pageFor(sceneType: sceneType)
            scrollTo(page: page)
        }
    }
}


private extension WWContainerController {
    
    func scrollTo(page: Int) {
        
        DispatchBlockToMainQueue {
            
            guard let collectionView = self.collectionView else {
                return
            }
            
            let width = collectionView.frame.width
            let xOffset = width * CGFloat(page)
            var contentOffset = collectionView.contentOffset
            contentOffset.x = xOffset
            collectionView.setContentOffset(contentOffset, animated: true)
        }
    }
}
