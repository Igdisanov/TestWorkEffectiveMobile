//
//  CategoryCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 23.08.2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    func configure(category: Category) {
        self.categoryLable.text = category.name
        self.setupShadowView(chosen: category.chosen)
        self.categoryImage.image = UIImage(named: category.image)
    }
    
    func setupShadowView(chosen: Bool) {
        shadowView.layer.cornerRadius = shadowView.frame.height/2
    
        if !chosen {
            shadowView.backgroundColor = UIColor(white: 1, alpha: 1)
            categoryLable.textColor = UIColor(white: 0, alpha: 1)
        } else {
            shadowView.backgroundColor = UIColor(red: 1.0, green: 0.429, blue: 0.304, alpha: 1)
            categoryLable.textColor = UIColor(red: 1.0, green: 0.429, blue: 0.304, alpha: 1)
        }
    }
    
    static var className: String {
        return String(describing: self)
    }
}
