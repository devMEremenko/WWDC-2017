//
//  WWExamVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

enum WWExamResult : Int {
    case Success
    case Fail
}

class WWExamVC: WWChildVC {
    
    let contentView = WWExamView()
    let controller = WWExamController()
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureModule()
    }
}

private extension WWExamVC {
    
    func checkRightPage() {
        
        let currentPage = self.controller.currentPage()

        
        let isSwift = currentPage == WWExamType.Swift.rawValue
        if isSwift {
            self.controller.update(page: currentPage, withResult: .Success)
            let delay = WWPhotoCellConstants.animationDuration + 0.3
            DispatchBlockAfter(delay: delay, block: {
                self.presentLetterController()
            })
        }
        else {
            self.controller.update(page: currentPage, withResult: .Fail)
        }
    }
    
    func presentLetterController() {
        
        let letterVC = WWLetterVC()
        letterVC.modalPresentationStyle = .overFullScreen

        letterVC.updateWith(nextBlock: {
            self.dismiss(animated: true, completion: {
                
                DispatchBlockAfter(delay: 0.3, block: {
                    WWSceneRouter.current.presentScreenWith(sceneType: .Trip)
                })
            })
        })

        self.present(letterVC, animated: true, completion: nil)
    }
}

private extension WWExamVC {
    
    func configureModule() {
        
        let models = WWExamBuilder.createExamModels()
        self.controller.attach(collectionView: self.contentView.collectionView)
        self.controller.updateWith(examModels: models)
        self.controller.updateWith { (page: Int) in
            self.contentView.update(currentPage: page)
        }
        
        self.contentView.update(numberOfPages: models.count)
        self.contentView.updateWith {
            self.checkRightPage()
        }
    }
}
