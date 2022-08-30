//
//  MainMainConfigurator.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

@objc
open class MainModuleConfigurator: NSObject {

    @objc
    public static func presentModule(from view: UIViewController,
                                     output: Any? = nil) {
        let viewController = configure(output: output)
        view.navigationController?.pushViewController(viewController, animated: true)
    }

    @objc
    public static func configure(output: Any? = nil) -> MainViewController {
       let bundle = Bundle(for: MainViewController.self)
       guard let viewController = UIStoryboard(name: String(describing: MainViewController.self),
                                     bundle: bundle).instantiateInitialViewController() as? MainViewController else {
           fatalError("Can't load MainViewController from storyboard, check that controller is initial view controller")
       }

        let router = MainRouter()
        router.view = viewController

        let presenter = MainPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.output = output as? MainModuleOutput

        let interactor = MainInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }
}