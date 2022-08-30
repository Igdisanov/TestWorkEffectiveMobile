//
//  MyCartMyCartViewController.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

open class MyCartViewController: UIViewController, ModuleTransitionable {

    // MARK: - IBOutlets
    
    @IBOutlet weak var productCartView: UIView!
    @IBOutlet weak var productCartCollectionView: UICollectionView!
    @IBOutlet weak var CheckoutButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var AddAddressButton: UIButton!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    
    
    
    
    

    // MARK: - Public Properties

    var output: MyCartViewOutput!
    var productInMyCart: MyCartModel?

    // MARK: - Life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private func
    
    private func setupUI() {
        backButton.layer.cornerRadius = 10
        AddAddressButton.layer.cornerRadius = 10
        productCartView.layer.cornerRadius = 30
        CheckoutButton.layer.cornerRadius = 10
        setupCollectionView()
        productCartCollectionView.delegate = self
        productCartCollectionView.dataSource = self
    }
    
    private func setupCollectionView() {
        
        let podBundle = Bundle(for: MainViewController.self)
        var bundle = podBundle
        if let bundleURL = podBundle.url(forResource: "TestWorkEffectiveMobile", withExtension: "bundle") {
            // swiftlint:disable force_unwrapping
            bundle = Bundle(url: bundleURL)!
            // swiftlint:enable force_unwrapping
        }
        productCartCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        productCartCollectionView.register(UINib(nibName: ProductInCartCell.className, bundle: bundle), forCellWithReuseIdentifier: ProductInCartCell.className)
        
        
    }

    // MARK: - IBActions
    
    @IBAction func backButtonTap(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: MyCartViewInput

extension MyCartViewController: MyCartViewInput {

        func setupInitialState(myCart: MyCartModel) {
            self.totalLabel.text = "$\(myCart.total) us"
            self.deliveryLabel.text = myCart.delivery
            self.productInMyCart = myCart
            productCartCollectionView.reloadData()
        }
        
    }




// MARK: - Collection
extension MyCartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let productInMyCart = self.productInMyCart else {return 0}
        return productInMyCart.basket.count

    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productInMyCart = self.productInMyCart else {return UICollectionViewCell()}
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductInCartCell.className, for: indexPath)
            if let actionCell = cell as? ProductInCartCell {
                actionCell.configure(basket: productInMyCart.basket[indexPath.row])
            }
            return cell

    }

//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }


    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 89)

    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 45

    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)

    }
}
