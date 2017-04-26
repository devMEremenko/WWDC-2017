//
//  WWTripView.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWTripViewConstants {
    static let planeSize = CGSize(width: 124, height: 58)
    static let startPoint = CGPoint(x: -40, y: 156)
    static let animationDuration = 7.5
    static let completionDuration = WWTripViewConstants.animationDuration - WWAnimation.transitionDuration - 2.8
}

class WWTripView: WWChildView {
    
    let imageView = UIImageView()
    let planeImageView = UIImageView()
    let animator = WWPlaneAnimator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureViews()
    }
    
    func startAnimation() {
        let startPoint = WWTripViewConstants.startPoint
        animator.animate(view: planeImageView,
                         startPoint: startPoint,
                         duration: WWTripViewConstants.animationDuration)
        
        DispatchBlockAfter(delay: WWTripViewConstants.completionDuration) {
             self.nextSelected()
        }
    }
}

private extension WWTripView {
    
    func configureViews() {
        
        self.clipsToBounds = true
        self.backgroundColor = WWColorTheme.whiteApp()
        
        self.addSubview(imageView)
        self.addSubview(planeImageView)
        
        imageView.image = UIImage(named: "trip_city")
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
        let size = WWTripViewConstants.planeSize
        let origin = WWTripViewConstants.startPoint
        planeImageView.frame = CGRect(origin: origin, size: size)
        planeImageView.image = UIImage(named: "plane")
    }
}
