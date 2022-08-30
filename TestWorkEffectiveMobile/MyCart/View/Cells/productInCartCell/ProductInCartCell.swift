//
//  prductInCartCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 30.08.2022.
//

import Foundation
import UIKit

class ProductInCartCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var countProduct: UILabel!
    @IBOutlet weak var stepperView: UIView!
    
    func configure(basket: DetailsForCart) {
        setupUI()
        installView(imageURL: basket.images)
        productNameLabel.text = basket.title
        productPriceLabel.text = "$\(basket.price)"
        
    }
    
    private func setupUI(){
        productImageView.layer.cornerRadius = 10
        stepperView.layer.cornerRadius = 13
        
    }
    
    func installView(imageURL: String) {
        guard let url = URL(string: imageURL) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }.resume()
    }

    
    static var className: String {
        return String(describing: self)
    }
    
}
