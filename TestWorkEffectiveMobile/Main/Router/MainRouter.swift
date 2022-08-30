//
//  MainMainRouter.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

class MainRouter {

    // MARK: - Public Properties

    weak var view: ModuleTransitionable?
    
}

// MARK: - MainRouterInput

extension MainRouter: MainRouterInput {
    
    func showProductDetails() {
        let productDetaisVC = ProductDetailsModuleConfigurator.configure(output: nil)
        self.view?.showModule(productDetaisVC)
    }

}
