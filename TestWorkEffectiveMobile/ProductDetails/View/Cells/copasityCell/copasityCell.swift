//
//  copasityCell.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 29.08.2022.
//

import Foundation
import UIKit

class copasityCell: UICollectionViewCell {
    
    @IBOutlet weak var copasityView: UIView!
    @IBOutlet weak var copasityLabel: UILabel!
    
    func configure(copasity: String, chosen: Bool?) {
        setupUI()
        copasityLabel.text = "\(copasity) GB"
        if let chosen = chosen, chosen {
            copasityView.backgroundColor = UIColor(red: 1.0, green: 0.429, blue: 0.304, alpha: 1)
            copasityLabel.textColor = UIColor(white: 1, alpha: 1)
        } else {
            copasityView.backgroundColor = UIColor(white: 1, alpha: 0)
            copasityLabel.textColor = UIColor(white: 0, alpha: 1)
        }
    }
    
    private func setupUI() {
        copasityView.layer.cornerRadius = 10
    }
    
    static var className: String {
        return String(describing: self)
    }
}
