//
//  MainMainViewController.swift
//  TestWorkEffectiveMobile
//
//  Created by Vadim Igdisanov on 22/08/2022.
//  Copyright © 2022 Igdisanov. All rights reserved.
//

import UIKit

open class MainViewController: UIViewController, ModuleTransitionable {

    // MARK: - IBOutlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UISearchBar!
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    @IBOutlet weak var HotSalesCollection: UICollectionView!
    
    @IBOutlet weak var bestSellerCollection: UICollectionView!
    
    
    // MARK: - Public Properties
    var shope: Shope?
    var output: MainViewOutput!
    // MARK: - Private Properties
    private var categories: [Category] = [Category(category: .Phone),
                                          Category(category: .Computer),
                                          Category(category: .Health),
                                          Category(category: .Books),
                                          Category(category: .Phone),
                                          Category(category: .Computer),
                                          Category(category: .Health),
                                          Category(category: .Books)]

    // MARK: - Life cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions
    
    // MARK: Private func
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        setupCollectionView()
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        HotSalesCollection.delegate = self
        HotSalesCollection.dataSource = self
        bestSellerCollection.delegate = self
        bestSellerCollection.dataSource = self
        setupSearch()
    }
    
    private func setupCollectionView() {
        let podBundle = Bundle(for: MainViewController.self)
        var bundle = podBundle
        if let bundleURL = podBundle.url(forResource: "TestWorkEffectiveMobile", withExtension: "bundle") {
            // swiftlint:disable force_unwrapping
            bundle = Bundle(url: bundleURL)!
            // swiftlint:enable force_unwrapping
        }
        categoryCollection.contentInset = .init(top: 0, left: 17, bottom: 0, right: 17)
        categoryCollection.register(UINib(nibName: CategoryCell.className, bundle: bundle), forCellWithReuseIdentifier: CategoryCell.className)
        HotSalesCollection.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        HotSalesCollection.register(UINib(nibName: HotSalesCell.className, bundle: bundle), forCellWithReuseIdentifier: HotSalesCell.className)
        bestSellerCollection.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        bestSellerCollection.register(UINib(nibName: BestSellerCell.className, bundle: bundle), forCellWithReuseIdentifier: BestSellerCell.className)
    }
    
    private func setupSearch() {
        searchButton.layer.cornerRadius = searchButton.frame.height/2
        searchView.layer.cornerRadius = 15
    }
    
}

// MARK: MainViewInput

extension MainViewController: MainViewInput {

    func setupInitialState(shope: Shope) {
        self.shope = shope
        HotSalesCollection.reloadData()
        bestSellerCollection.reloadData()
        }
        
    }

// MARK: - categoryCollection
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoryCollection {
            return categories.count
        } else if collectionView == HotSalesCollection {
            return shope?.homeStore?.count ?? 0
        } else {
            return shope?.bestSeller?.count ?? 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.className, for: indexPath)
            if let actionCell = cell as? CategoryCell {
                actionCell.configure(category: categories[indexPath.row])
            }
            return cell
        } else if collectionView == HotSalesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.className, for: indexPath)
            if let actionCell = cell as? HotSalesCell, let homeStore = shope?.homeStore?[indexPath.row] {
                actionCell.configure(product: homeStore)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.className, for: indexPath)
            if let actionCell = cell as? BestSellerCell, let bestSeller = shope?.bestSeller?[indexPath.row] {
                actionCell.configure(product: bestSeller)
        }
            return cell
    }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCollection {
            for (indexCategory, _) in self.categories.enumerated() {
                if indexCategory == indexPath.row {
                    self.categories[indexCategory].chosen = true
                } else {
                    self.categories[indexCategory].chosen = false
                }
            }
            categoryCollection.reloadData()
        } else {
            output.tapAtProduct()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == HotSalesCollection {
        return CGSize(width: self.view.frame.width - 34, height: 182)
        } else if collectionView == categoryCollection {
            return CGSize(width: 71, height: 93)
        } else {
            return CGSize(width: (self.view.frame.width - 45)/2, height: 227)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == HotSalesCollection {
            return 34
        } else if collectionView == categoryCollection {
            return 23
        } else {
            return 11
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == HotSalesCollection {
            return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        } else {
            return UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        }
    }
}

