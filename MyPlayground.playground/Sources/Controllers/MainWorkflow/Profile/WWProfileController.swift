//
//  WWProfileController.swift
//  WWDC
//
//  Created by Maxim Eremenko on 4/1/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWProfileController: NSObject {
    
    internal weak var collectionView : UICollectionView?
    var models : [WWPhotoDomainModel]?
    var pageBlock : ((Int)->())?
    
    func attach(collectionView: UICollectionView?) {
        
        if let collectionView = collectionView {
            updateWith(collectionView: collectionView)
        }
    }
    
    func updateWith(models: [WWPhotoDomainModel]) {
        self.models = models
        
        DispatchBlockToMainQueue {
            self.collectionView?.reloadData()
        }
    }
    
    func updateWith(pageBlock: @escaping WWPageBlock) {
        self.pageBlock = pageBlock
    }
}


private extension WWProfileController {
    
    func photoModel(at indexPath: IndexPath) -> WWPhotoDomainModel? {
        
        if let models = self.models {
            if indexPath.item < models.count {
                return models[indexPath.item]
            }
        }
        return nil
    }
    
    func currentPage() -> Int {
        
        guard let collectionView = collectionView else {
            return 0
        }
        
        guard collectionView.numberOfSections > 0 else {
            return 0
        }
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        let insets = layout.sectionInset.left + layout.sectionInset.right
        
        let contentWidth = collectionView.contentSize.width + insets
        let itemWidth = contentWidth / CGFloat(itemsCount)
        let itemNumber = collectionView.contentOffset.x / itemWidth
        
        return Int(roundf(Float(itemNumber)))
    }
}


private extension WWProfileController {
    
    func updateWith(collectionView: UICollectionView) {
        
        DispatchBlockToMainQueue {
            collectionView.register(WWPhotoCell.self,
                                    forCellWithReuseIdentifier: WWCellIdentifiers.photo)
            collectionView.dataSource = self
            collectionView.delegate = self
            
            self.collectionView = collectionView
        }
    }
}


extension WWProfileController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let models = self.models else {
            return 0
        }
        
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WWCellIdentifiers.photo, for: indexPath)
        
        if let cell = cell as? WWPhotoCell {
            let model = photoModel(at: indexPath)
            cell.updateWith(image: model?.image)
            cell.imageView.contentMode = .scaleAspectFit
            cell.contentView.backgroundColor = WWColorTheme.whiteApp()
        }
        
        return cell
    }
}


extension WWProfileController : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = currentPage()
        self.pageBlock?(page)
    }
}


extension WWProfileController : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return sizeFor(indexPath: indexPath)
    }
    
    func sizeFor(indexPath: IndexPath) -> CGSize {
        
        if let model = photoModel(at: indexPath) {
            if let image = model.image {
                
                let width = widthForImageAt(size: image.size)
                let height = WWProfileContentViewConstants.collectionHeight
                return CGSize(width: CGFloat(width), height: CGFloat(height))
            }
        }
        
        return CGSize.zero
    }
    
    func widthForImageAt(size: CGSize) -> CGFloat {
        let maxHeight = WWProfileContentViewConstants.collectionHeight
        
        return CGFloat(maxHeight) * size.width / size.height
    }
}
