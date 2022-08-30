//
//  ProductDetailsProductDetailsRouter.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

class ProductDetailsRouter {

    // MARK: - Public Properties

    weak var view: ModuleTransitionable?
    
}

// MARK: - ProductDetailsRouterInput

extension ProductDetailsRouter: ProductDetailsRouterInput {
    
    func showMyCart() {
        let myCartVC = MyCartModuleConfigurator.configure(output: nil)
        self.view?.showModule(myCartVC)
    }

}
