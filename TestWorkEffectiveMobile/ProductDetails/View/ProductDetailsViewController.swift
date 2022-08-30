//
//  ProductDetailsProductDetailsViewController.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

open class ProductDetailsViewController: UIViewController, ModuleTransitionable {
    
    // MARK: - IBOutlets
    
    
    @IBOutlet weak var productContentView: UIView!
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    
    @IBOutlet weak var countProductLabel: UILabel!
    @IBOutlet weak var countProductView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var copacityCollectionView: UICollectionView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var cartButton: UIButton!
    
    
    @IBOutlet weak var cpuLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var ssdLabel: UILabel!
    @IBOutlet weak var sdLabel: UILabel!
    
    
    
    
    
    
    
    // MARK: - Public Properties
    
    var output: ProductDetailsViewOutput!
    var details: Details?
    
    // MARK: - Private Properties
    
    private var chosenColors: [Bool]? = []
    private var chosenCopasyties: [Bool]? = []
    
    // MARK: - Life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        cetupUI()
    }
    
    // MARK: - private func
    
    private func cetupUI() {
        setupProductContentView()
        countProductView.layer.cornerRadius = countProductView.frame.width/2
        backButton.layer.cornerRadius = 10
        cartButton.layer.cornerRadius = 10
        favoriteButton.layer.cornerRadius = 10
        addToCartButton.layer.cornerRadius = 10
        setupCollectionView()
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        copacityCollectionView.delegate = self
        copacityCollectionView.dataSource = self
    }
    
    private func setupProductContentView() {
        productContentView.layer.cornerRadius = 30
        productContentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        productContentView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        productContentView.layer.shadowRadius = 30
        productContentView.layer.shadowOpacity = 1
        productContentView.layer.masksToBounds = false
        productContentView.layer.shadowPath = UIBezierPath(roundedRect: productContentView.bounds, cornerRadius: 30).cgPath
    }
    
    private func setupCollectionView() {
        let podBundle = Bundle(for: MainViewController.self)
        var bundle = podBundle
        if let bundleURL = podBundle.url(forResource: "TestWorkEffectiveMobile", withExtension: "bundle") {
            // swiftlint:disable force_unwrapping
            bundle = Bundle(url: bundleURL)!
            // swiftlint:enable force_unwrapping
        }
        productImageCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        productImageCollectionView.register(UINib(nibName: ProductImageCell.className, bundle: bundle), forCellWithReuseIdentifier: ProductImageCell.className)
        colorCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        colorCollectionView.register(UINib(nibName: ColorCell.className, bundle: bundle), forCellWithReuseIdentifier: ColorCell.className)
        copacityCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        copacityCollectionView.register(UINib(nibName: copasityCell.className, bundle: bundle), forCellWithReuseIdentifier: copasityCell.className)
        
    }
    
    
    // MARK: - IBActions
    
    @IBAction func backButtonTap(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func myCartButton(_ sender: Any) {
        output.tapAtMyCart()
    }
    
    
}

// MARK: ProductDetailsViewInput

extension ProductDetailsViewController: ProductDetailsViewInput {
    
    func setupInitialState(details: Details) {
        self.details = details
        self.productNameLabel.text = details.title
        self.cpuLabel.text = details.CPU
        self.cameraLabel.text = details.camera
        self.ssdLabel.text = details.ssd
        self.sdLabel.text = details.sd
        self.addToCartButton.titleLabel?.text = "Add to Cart            $\(details.price)"
        productImageCollectionView.reloadData()
        colorCollectionView.reloadData()
        copacityCollectionView.reloadData()
        guard let colors = details.color, let capacities = details.capacity else {return}
        for _ in 0...colors.count {
            chosenColors?.append(false)
        }
        for _ in 0...capacities.count {
            chosenCopasyties?.append(false)
        }
    }
    
}



// MARK: - Collection
extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let details = details else {return 0}
        if collectionView == productImageCollectionView {
            return  details.images?.count ?? 0
        } else if collectionView == colorCollectionView {
            return details.color?.count ?? 0
        } else {
            return details.capacity?.count ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let details = details else {return UICollectionViewCell()}
        if collectionView == productImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCell.className, for: indexPath)
            if let actionCell = cell as? ProductImageCell {
                guard let images = details.images else {return UICollectionViewCell()}
                actionCell.configure(imageURL: images[indexPath.row])
            }
            return cell
        } else if collectionView == colorCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.className, for: indexPath)
            if let actionCell = cell as? ColorCell {
                guard let colors = details.color else {return UICollectionViewCell()}
                actionCell.configure(color: colors[indexPath.row], chosen: chosenColors?[indexPath.row])
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: copasityCell.className, for: indexPath)
            if let actionCell = cell as? copasityCell {
                guard let capacities = details.capacity else {return UICollectionViewCell()}
                actionCell.configure(copasity: capacities[indexPath.row], chosen: chosenCopasyties?[indexPath.row])
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = details else {return}
        
        if collectionView == colorCollectionView {
            guard let colors = details.color else {return}
            for (indexCategory, _) in colors.enumerated() {
                if indexCategory == indexPath.row {
                    self.chosenColors?[indexCategory] = true
                } else {
                    self.chosenColors?[indexCategory] = false
                }
            }
            colorCollectionView.reloadData()
        } else if collectionView == copacityCollectionView {
            guard let capacities = details.capacity else {return}
            for (indexCategory, _) in capacities.enumerated() {
                if indexCategory == indexPath.row {
                    self.chosenCopasyties?[indexCategory] = true
                } else {
                    self.chosenCopasyties?[indexCategory] = false
                }
            }
            copacityCollectionView.reloadData()
        }
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == productImageCollectionView {
            return CGSize(width: 266, height: productImageCollectionView.frame.height - 8)
        } else if collectionView == colorCollectionView {
            return CGSize(width: 40, height: 40)
        } else {
            return CGSize(width: 72, height: 30)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == productImageCollectionView {
            return  32
        } else if collectionView == colorCollectionView {
            return 18
        } else {
            return 20
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insetForSection = UIEdgeInsets()
        if collectionView == productImageCollectionView {
            insetForSection =  UIEdgeInsets(top: 0, left: (self.view.frame.width - 266)/2, bottom: 0, right: (self.view.frame.width - 266)/2)
        }
        return insetForSection
    }
    
}
