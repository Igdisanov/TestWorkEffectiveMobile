//
//  MainMainInteractor.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

class MainInteractor {

    // MARK: - Public Properties
    
    weak var output: MainInteractorOutput!

    // MARK: - MainInteractorInput
    
}

// MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {

    
    func fetchData(for url: String, completion: @escaping (_ shope: Shope) -> Void) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                do {
                    let shop = try JSONDecoder().decode(Shope.self, from: data)
                    completion(shop)
                } catch let error {
                    print("Error serialization jsone", error)
                }
            }
        }.resume()
    }
}
