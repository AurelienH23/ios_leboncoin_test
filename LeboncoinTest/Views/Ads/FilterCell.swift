//
//  FilterCell.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 05/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    // MARK: View elements
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .main
        view.layer.cornerRadius = 15
        return view
    }()
    
    let filterName: UILabel = {
        let label = UILabel()
        label.textColor = .main
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        addSubviews(backView, filterName)
        backView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: 0, paddingBottom: .mediumSpace, paddingRight: 0, width: 0, height: 0)
        filterName.anchor(to: self)
    }
    
    func arrangeView(ifSelected: Bool) {
        filterName.textColor = ifSelected ? .white : .main
        backView.backgroundColor = ifSelected ? .main : .clear
    }
    
}
