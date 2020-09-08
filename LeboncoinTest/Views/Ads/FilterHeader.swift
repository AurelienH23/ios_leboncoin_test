//
//  FilterHeader.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 05/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func didSelectFilter(at index: Int)
}

let categories = ["Tout", "Véhicules", "Vêtements", "Bricolage", "Mobilier", "Loisirs", "Immobilier", "Multimédia", "Électronique", "Service", "Animaux", "Enfants"]

class FilterHeader: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    
    var delegate: FilterDelegate?
    
    let cellId = "cellId"
    
    var filters = [String]() {
        didSet {
            reloadCollectionView()
        }
    }
    
    var selectedFilter = "Tout" {
        didSet {
            reloadCollectionView()
        }
    }
    
    // MARK: View elements
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "backgroundColor")
        cv.register(FilterCell.self, forCellWithReuseIdentifier: cellId)
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        filters = categories
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs

    fileprivate func setupViews() {
        addSubview(collectionView)
        collectionView.anchor(to: self)
    }
    
    fileprivate func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Collection view
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterCell
        cell.filterName.text = filters[indexPath.item]
        cell.arrangeView(ifSelected: filters[indexPath.item] == selectedFilter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.frame.height
        let cellWidth = filters[indexPath.item].width(withConstrainedHeight: cellHeight, font: .boldSystemFont(ofSize: 18))
        return CGSize(width: cellWidth + 2 * .mediumSpace, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter = filters[indexPath.item]
        delegate?.didSelectFilter(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: .mediumSpace, bottom: 0, right: .mediumSpace)
    }
    
}
