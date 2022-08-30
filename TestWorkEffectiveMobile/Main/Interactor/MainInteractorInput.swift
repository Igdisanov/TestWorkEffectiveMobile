//
//  MainMainInteractorInput.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import Foundation

protocol MainInteractorInput {

    func fetchData(for url: String, completion: @escaping (_ investorMainPropertyItems: Shope) -> Void)
}
