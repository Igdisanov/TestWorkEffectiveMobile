//
//  HotSalesCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 24.08.2022.
//

import UIKit

class HotSalesCell: UICollectionViewCell {
    
    
    @IBOutlet weak var newProductNotificationView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var buyNowButton: UIButton!
    
    func configure(product: Product) {
        setupUI()
        self.productNameLabel.text = product.title
        self.subtitleLabel.text = product.subtitle
        if let _ =  product.isNew {
            newProductNotificationView.isHidden = false
        }
        
        guard let imageURL = product.picture else {return}
        installView(imageURL: imageURL)
    }
    
    func setupUI() {
        newProductNotificationView.layer.cornerRadius = newProductNotificationView.frame.height/2
        newProductNotificationView.isHidden = true
        buyNowButton.layer.cornerRadius = 5
        productImageView.layer.cornerRadius = 10
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
