//
//  ProductImageCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 29.08.2022.
//

import Foundation
import UIKit

class ProductImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(imageURL: String) {
        setupUI()
        installView(imageURL: imageURL)
    }
    
    private func setupUI(){
        imageView.layer.cornerRadius = 20
       
    }
    
    func installView(imageURL: String) {
        guard let url = URL(string: imageURL) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }

    
    static var className: String {
        return String(describing: self)
    }
}
