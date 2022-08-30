//
//  ProductDetailsProductDetailsInteractor.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

class ProductDetailsInteractor {

    // MARK: - Public Properties
    
    weak var output: ProductDetailsInteractorOutput!

    // MARK: - ProductDetailsInteractorInput
    
}

// MARK: - ProductDetailsInteractorInput

extension ProductDetailsInteractor: ProductDetailsInteractorInput {
    
    
    func fetchData(for url: String, completion: @escaping (_ details: Details) -> Void) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                do {
                    let details = try JSONDecoder().decode(Details.self, from: data)
                    completion(details)
                } catch let error {
                    print("Error serialization jsone", error)
                }
            }
        }.resume()
    }

}
