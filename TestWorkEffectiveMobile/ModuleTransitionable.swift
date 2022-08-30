//
//  ModuleTransitionable.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22.08.2022.
//

import UIKit

public protocol ModuleTransitionable: AnyObject {
    func showModule(_ module: UIViewController)
    func dismissView(animated: Bool, completion: (() -> Void)?)
    func presentModule(_ module: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
    func push(module: UIViewController, animated: Bool)
    func closeModule(animated: Bool, completion: (() -> Void)?)
    func pop(directional: CATransitionSubtype)
}

public extension ModuleTransitionable where Self: UIViewController {

    func closeModule(animated: Bool, completion: (() -> Void)?) {
        
        guard let navigationController = self.navigationController,
              !self.isBeingPresented else {
            self.dismiss(animated: animated, completion: completion)
            return
        }
        
        let topViewController = navigationController.viewControllers.first
        
        if navigationController.presentingViewController != nil,
           topViewController === self {
            self.dismiss(animated: animated, completion: completion)
        } else {
            self.pop(animated: animated)
        }
    }
    
    func showModule(_ module: UIViewController) {
        self.show(module, sender: nil)
    }

    func dismissView(animated: Bool, completion: (() -> Void)?) {
        self.presentingViewController?.dismiss(animated: animated, completion: completion)
    }

    func presentModule(_ module: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.present(module, animated: animated, completion: completion)
    }

    func pop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }

    func push(module: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(module, animated: animated)
    }
    
    func pop(directional: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = directional
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }
}

