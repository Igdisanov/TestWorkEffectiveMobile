//
//  MyCartMyCartInteractor.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//
import UIKit
class MyCartInteractor {

    // MARK: - Public Properties
    
    weak var output: MyCartInteractorOutput!

    // MARK: - MyCartInteractorInput
    
}

// MARK: - MyCartInteractorInput

extension MyCartInteractor: MyCartInteractorInput {

    
    func fetchData(for url: String, completion: @escaping (_ myCart: MyCartModel) -> Void) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                do {
                    let myCart = try JSONDecoder().decode(MyCartModel.self, from: data)
                    completion(myCart)
                } catch let error {
                    print("Error serialization jsone", error)
                }
            }
        }.resume()
    }
}
