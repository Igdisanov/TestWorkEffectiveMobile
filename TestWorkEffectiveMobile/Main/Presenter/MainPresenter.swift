//
//  MainMainPresenter.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

class MainPresenter: MainInteractorOutput {

    // MARK: Public Properties
    
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    var output: MainModuleOutput?
    let urlForShope = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    
    func downloadShope() {
        interactor.fetchData(for: urlForShope) { [weak self] shope in
            self?.view.setupInitialState(shope: shope)
        }
    }

}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {

    func viewDidLoad() {
        downloadShope()
    }
    
    func tapAtProduct() {
        router.showProductDetails()
    }
    

}

// MARK: - MainModuleInput

extension MainPresenter: MainModuleInput {

}
