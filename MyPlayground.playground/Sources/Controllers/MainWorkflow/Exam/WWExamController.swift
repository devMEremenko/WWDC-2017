//
//  WWExamController.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/30/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

typealias WWPageBlock = ((Int)->())

class WWExamController: NSObject {
    
    internal weak var collectionView : UICollectionView?
    var examModels : [WWPhotoDomainModel]?
    var pageBlock : ((Int)->())?
    
    
    func attach(collectionView: UICollectionView?) {
        
        if let collectionView = collectionView {
            updateWith(collectionView: collectionView)
        }
    }
    
    func updateWith(examModels: [WWPhotoDomainModel]) {
        self.examModels = examModels
        
        DispatchBlockToMainQueue { 
            self.collectionView?.reloadData()
        }
    }
    
    func updateWith(pageBlock: @escaping WWPageBlock) {
        self.pageBlock = pageBlock
    }
    
    func currentPage() -> Int {
        return pageFrom(scrollView: self.collectionView!)
    }
    
    func update(page: Int, withResult: WWExamResult) {
        highlightCellWith(page: page, result: withResult)
    }
}


private extension WWExamController {
    
    func examModel(at indexPath: IndexPath) -> WWPhotoDomainModel? {
        
        if let models = self.examModels {
            if indexPath.item < models.count {
                return models[indexPath.item]
            }
        }
        return nil
    }
    
    func pageFrom(scrollView: UIScrollView?) -> Int {
        
        guard let scrollView = scrollView else {
            return 0
        }
        
        let width = scrollView.frame.width
        return Int(roundf(Float(scrollView.contentOffset.x) / Float(width)))
    }
}


private extension WWExamController {
    
    func updateWith(collectionView: UICollectionView) {
        
        DispatchBlockToMainQueue {
            collectionView.register(WWPhotoCell.self,
                                    forCellWithReuseIdentifier: WWCellIdentifiers.photo)
            collectionView.dataSource = self
            collectionView.delegate = self
            
            self.collectionView = collectionView
        }
    }
    
    func highlightCellWith(page: Int, result: WWExamResult) {
        
        let indexPath = IndexPath(item: page, section: 0)
        let cell = self.collectionView?.cellForItem(at: indexPath)
        
        guard cell != nil, cell is WWPhotoCell else {
            return
        }
        let photoCell = cell as! WWPhotoCell
        
        let title = WWExamBuilder.titleFor(result: result)
        photoCell.updateInfo(title: title)
    }
}


extension WWExamController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let examModels = self.examModels else {
            return 0
        }
        
        return examModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WWCellIdentifiers.photo, for: indexPath)
        
        if let cell = cell as? WWPhotoCell {
            let model = examModel(at: indexPath)
            cell.updateWith(image: model?.image)
            cell.imageView.contentMode = .scaleAspectFit
            cell.contentView.backgroundColor = WWColorTheme.grayCode()
        }
        
        return cell
    }
}


extension WWExamController : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = pageFrom(scrollView: scrollView)
        self.pageBlock?(page)
    }
}

