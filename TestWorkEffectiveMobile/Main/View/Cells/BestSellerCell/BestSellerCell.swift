//
//  BestSellerCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 26.08.2022.
//

import UIKit

class BestSellerCell: UICollectionViewCell {
    
    @IBOutlet weak var contentProductView: UIView!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var priceWithoutDiscountLabel: UILabel!
    
    @IBOutlet weak var discountPricelabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    func configure(product: Product) {
        setupUI()
        self.productNameLabel.text = product.title
        
        guard let discountPrice = product.discountPrice, let priceWithoutDiscount = product.priceWithout_discount  else {return}
        self.discountPricelabel.text = "\(String(describing: discountPrice))"
        self.priceWithoutDiscountLabel.text = "\(String(describing: priceWithoutDiscount))"
        
        guard let imageURL = product.picture else {return}
        installView(imageURL: imageURL)
        
        if let favorite = product.isFavorites, favorite {
            favoritesButton.imageView?.image = UIImage(named: "Vector (5)")
        } else {
            favoritesButton.imageView?.image = UIImage(named: "Vector (4)")
        }
    }
    
    func setupUI() {
        contentProductView.layer.cornerRadius = 10
        favoritesButton.layer.cornerRadius = favoritesButton.frame.width/2
        favoritesButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        favoritesButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        favoritesButton.layer.shadowRadius = 20
        favoritesButton.layer.shadowOpacity = 1
        favoritesButton.layer.masksToBounds = false
        favoritesButton.layer.shadowPath = UIBezierPath(roundedRect: favoritesButton.bounds, cornerRadius: favoritesButton.frame.width/2).cgPath
        discountPricelabel.attributedText = NSAttributedString(string: "$1,500", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
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
