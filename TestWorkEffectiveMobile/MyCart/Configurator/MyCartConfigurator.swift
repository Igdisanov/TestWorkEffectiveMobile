//
//  MyCartMyCartConfigurator.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

@objc
open class MyCartModuleConfigurator: NSObject {

    @objc
    public static func presentModule(from view: UIViewController,
                                     output: Any? = nil) {
        let viewController = configure(output: output)
        view.navigationController?.pushViewController(viewController, animated: true)
    }

    @objc
    public static func configure(output: Any? = nil) -> MyCartViewController {
       let bundle = Bundle(for: MyCartViewController.self)
       guard let viewController = UIStoryboard(name: String(describing: MyCartViewController.self),
                                     bundle: bundle).instantiateInitialViewController() as? MyCartViewController else {
           fatalError("Can't load MyCartViewController from storyboard, check that controller is initial view controller")
       }

        let router = MyCartRouter()
        router.view = viewController

        let presenter = MyCartPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.output = output as? MyCartModuleOutput

        let interactor = MyCartInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }
}