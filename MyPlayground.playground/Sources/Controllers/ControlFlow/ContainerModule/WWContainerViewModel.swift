//
//  WWContainerViewModel.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/25/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

protocol WWContainerViewModelInput : class {
    
}

protocol WWContainerViewModelOutput : class {
    func updateWith(scenarioModel: WWScenarioDomainModel)
}

class WWContainerViewModel: NSObject, WWContainerViewModelInput {
    
    weak var output: WWContainerViewModelOutput?
    
    func loadScenario() {
        let scenarionModel = WWScenarioBuilder.createScenario()
        self.output?.updateWith(scenarioModel: scenarionModel)
    }
}
