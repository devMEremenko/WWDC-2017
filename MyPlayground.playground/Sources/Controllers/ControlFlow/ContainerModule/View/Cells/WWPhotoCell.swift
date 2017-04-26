//
//  WWPhotoCell.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWPhotoCellConstants {
    static let animationDuration = 0.4
}

class WWPhotoCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func updateWith(image: UIImage?) {
        self.imageView.image = image
    }
    
    func updateInfo(title: String?) {
        animatedUpdateInfo(title: title)
    }
}

private extension WWPhotoCell {
    
    func animatedUpdateInfo(title: String?) {
        
        DispatchBlockToMainQueue {
            
            let duration = WWPhotoCellConstants.animationDuration
            
            UIView.transition(with: self.infoLabel,
                              duration: duration,
                              options: [.transitionCrossDissolve, .beginFromCurrentState],
                              animations: {
                                self.infoLabel.text = title
                                self.infoLabel.alpha = 1.0
            }, completion: { finished in
                
                if finished {
                    _ = [UIView .animate(withDuration: duration,
                                     delay: 1,
                                     options: [.transitionCrossDissolve, .beginFromCurrentState],
                                     animations: { 
                                        self.infoLabel.alpha = 0
                    }, completion: nil)]
                }
            })
        }
    }
}

private extension WWPhotoCell {
    
    func configureViews() {
        self.contentView.clipsToBounds = true
        self.contentView.backgroundColor = WWColorTheme.whiteApp()
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.infoLabel)

        self.imageView.contentMode = .scaleAspectFill
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        infoLabel.alpha = 0
        infoLabel.textColor = WWColorTheme.whiteApp()
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.regular(size: 19)
        infoLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(22)
            make.height.equalTo(26)
            make.left.right.equalTo(self)
        }
    }
}
