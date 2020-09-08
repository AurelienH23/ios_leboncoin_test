//
//  AdsViewController.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 02/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class AdsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, FilterDelegate, ErrorCellDelegate {
    
    // MARK: Properties
    
    var isRefreshing = false
    var isNetworkError = false
    
    let cellId = "cellId"
    let errorCellId = "errorCellId"
    let headerId = "headerId"
    
    let viewModel = AdViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupCollectionView()
        setupBinders()
        fetchAds()
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupNavbar() {
        title = "Annonces"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        
        let header = UICollectionView.elementKindSectionHeader
        collectionView.register(FilterHeader.self, forSupplementaryViewOfKind: header, withReuseIdentifier: headerId)
        collectionView.register(AdCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: errorCellId)
    }
    
    fileprivate func fetchAds() {
        isNetworkError = false
        viewModel.fetchAds(completion: {}) { [weak self] in
            self?.isNetworkError = true
            self?.isRefreshing = false
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setupBinders() {
        viewModel.filteredAds.bind { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: Collection view
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! FilterHeader
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: isNetworkError ? 0 : 62)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isNetworkError ? 1 : viewModel.filteredAds.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isNetworkError {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: errorCellId, for: indexPath) as! ErrorCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AdCell
            viewModel.configureCell(cell, at: indexPath.item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 2 * .mediumSpace, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .mediumSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .mediumSpace, left: .mediumSpace, bottom: .mediumSpace, right: .mediumSpace)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = AdDetailsViewController(for: viewModel.filteredAds.value[indexPath.item])
        present(detailsViewController, animated: true, completion: nil)
    }
    
    // MARK: Filter delegate
    
    func didSelectFilter(at index: Int) {
        viewModel.didSelectFilter(at: index)
    }
    
    // MARK: Error cell delegate
    
    func refreshAds() {
        if !isRefreshing {
            isRefreshing = true
            fetchAds()
        }
    }

}

