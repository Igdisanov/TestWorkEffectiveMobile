//
//  MyCartMyCartPresenter.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

class MyCartPresenter: MyCartInteractorOutput {

    // MARK: Public Properties
    
    weak var view: MyCartViewInput!
    var interactor: MyCartInteractorInput!
    var router: MyCartRouterInput!
    var output: MyCartModuleOutput?
    let urlForMyCart = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    
    func downloadDetails() {
        interactor.fetchData(for: urlForMyCart) { [weak self] myCart in
            
                self?.view.setupInitialState(myCart: myCart)
            
        }
    }

}

// MARK: - MyCartViewOutput

extension MyCartPresenter: MyCartViewOutput {

    func viewDidLoad() {
    	downloadDetails()
    }

}

// MARK: - MyCartModuleInput

extension MyCartPresenter: MyCartModuleInput {

}
