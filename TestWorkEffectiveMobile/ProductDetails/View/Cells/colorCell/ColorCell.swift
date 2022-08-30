//
//  ColorCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 29.08.2022.
//

import Foundation
import UIKit


class ColorCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var chosenColorImageView: UIImageView!
    
    func configure(color: String, chosen: Bool?) {
        setupUI()
        colorView.backgroundColor = UIColor(hex: color)
        if let chosen = chosen, chosen {
            chosenColorImageView.isHidden = false
        } else {
            chosenColorImageView.isHidden = true

        }
    }
    private func setupUI() {
        colorView.layer.cornerRadius = colorView.frame.width/2
    }
    
    static var className: String {
        return String(describing: self)
    }
    
}
