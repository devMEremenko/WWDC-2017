//
//  WWContainerConstants.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

struct WWContainerConstants {
    static let collectionSize = CGSize(width: kScreenWidth(), height: 240)
    static let childFrame = CGRect(x: 0,
                                   y: WWContainerConstants.collectionSize.height,
                                   width: kScreenWidth(),
                                   height: kScreenHeight() - WWContainerConstants.collectionSize.height)
}

struct WWCellIdentifiers {
    static let photo = NSStringFromClass(WWPhotoCell.self)
}
