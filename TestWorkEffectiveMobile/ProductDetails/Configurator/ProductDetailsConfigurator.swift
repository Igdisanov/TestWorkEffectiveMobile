//
//  ProductDetailsProductDetailsConfigurator.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

@objc
open class ProductDetailsModuleConfigurator: NSObject {

    @objc
    public static func presentModule(from view: UIViewController,
                                     output: Any? = nil) {
        let viewController = configure(output: output)
        view.navigationController?.pushViewController(viewController, animated: true)
    }

    @objc
    public static func configure(output: Any? = nil) -> ProductDetailsViewController {
       let bundle = Bundle(for: ProductDetailsViewController.self)
       guard let viewController = UIStoryboard(name: String(describing: ProductDetailsViewController.self),
                                     bundle: bundle).instantiateInitialViewController() as? ProductDetailsViewController else {
           fatalError("Can't load ProductDetailsViewController from storyboard, check that controller is initial view controller")
       }

        let router = ProductDetailsRouter()
        router.view = viewController

        let presenter = ProductDetailsPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.output = output as? ProductDetailsModuleOutput

        let interactor = ProductDetailsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }
}