//
//  ProductDetailsProductDetailsPresenter.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import Foundation

class ProductDetailsPresenter: ProductDetailsInteractorOutput {

    // MARK: Public Properties
    
    weak var view: ProductDetailsViewInput!
    var interactor: ProductDetailsInteractorInput!
    var router: ProductDetailsRouterInput!
    var output: ProductDetailsModuleOutput?
    let urlForDetails = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    
    func downloadDetails() {
        interactor.fetchData(for: urlForDetails) { [weak self] details in
            
                self?.view.setupInitialState(details: details)
            
        }
    }

}

// MARK: - ProductDetailsViewOutput

extension ProductDetailsPresenter: ProductDetailsViewOutput {

    func viewDidLoad() {
    	downloadDetails()
    }
    
    func tapAtMyCart() {
        router.showMyCart()
    }

}

// MARK: - ProductDetailsModuleInput

extension ProductDetailsPresenter: ProductDetailsModuleInput {

}
