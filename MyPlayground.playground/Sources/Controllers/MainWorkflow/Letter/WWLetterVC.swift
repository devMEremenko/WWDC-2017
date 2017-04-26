//
//  WWLetterVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWLetterVC: WWChildVC {
    
    let contentView = WWLetterView()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateWith(nextBlock: CodeBlock) {
        self.contentView.updateWith(nextBlock: nextBlock)
    }
}
