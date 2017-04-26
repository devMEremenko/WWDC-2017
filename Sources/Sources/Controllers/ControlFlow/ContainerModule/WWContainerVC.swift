//
//  WWContainerVC.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

public class WWContainerVC: WWSceneVC {
    
    var viewModel = WWContainerViewModel()
    var contentView = WWContainerView()
    var controller = WWContainerController()
    public override var sceneType: WWSceneType? {
        didSet {
            if self.isViewLoaded {
                self.controller.updateWith(sceneType: sceneType!)
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configureModule()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureModule()
    }
    
    public override func loadView() {
        self.view = self.contentView
    }
    
    public override func childFrame() -> CGRect {
        return WWContainerConstants.childFrame
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.loadScenario()
    }
    
    override func animatePlane(completion: CodeBlock) {
        contentView.animatePlane(completion: completion)
    }
    
    override func animatedFinalScene(completion: CodeBlock?) {
        contentView.animatedFinalScene(completion: completion)
    }
    
    override func dissmissAnimatedViews(completion: CodeBlock?) {
        contentView.dissmissAnimatedViews(completion: completion)
    }
}

private extension WWContainerVC {
    
    func configureModule() {
        self.viewModel.output = self
        self.controller.attach(collectionView: contentView.collectionView!)
    }
}

extension WWContainerVC : WWContainerViewModelOutput {
    
    internal func updateWith(scenarioModel: WWScenarioDomainModel) {
        self.controller.updateWith(scenarioModel: scenarioModel)
        self.controller.updateWith(sceneType: sceneType!)
    }
}
