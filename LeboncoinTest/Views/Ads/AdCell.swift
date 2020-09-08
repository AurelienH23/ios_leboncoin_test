//
//  AdCell.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 04/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class AdCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var ad: Ad? {
        didSet {
            guard let ad = ad else { return }
            categoryLabel.text = categories[ad.category_id].uppercased()
            productTitle.text = ad.title
            productPrice.text = ad.formattedPrice
            urgentLabel.alpha = ad.is_urgent ? 1 : 0
            
            if let thumb = ad.images_url.thumb {
                productImage.fetchImage(for: thumb)
            }
        }
    }
    
    // MARK: View elements
    
    let productImage = OnlineImageView(frame: .zero)
    let productTitle = TitleLabel()
    let productPrice = BoldLabel()
    let urgentLabel = UrgentLabel(size: .small)
    let categoryLabel = SecondaryLabel()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productTitle.text = nil
        productPrice.text = nil
        productImage.image = nil
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        layer.cornerRadius = .largeCornerRadius
        backgroundColor = UIColor(named: "backgroundLightColor")
        
        addSubviews(productImage, categoryLabel, productTitle, productPrice, urgentLabel)
        
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: .mediumSpace, paddingRight: 0, width: 130, height: 0)
        categoryLabel.anchor(top: productImage.topAnchor, left: productImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: .smallSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 17)
        productTitle.anchor(top: categoryLabel.bottomAnchor, left: categoryLabel.leftAnchor, bottom: nil, right: categoryLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        let maxTitleHeight = frame.height - 17 - 23 - 2 * .mediumSpace
        productTitle.heightAnchor.constraint(lessThanOrEqualToConstant: maxTitleHeight).isActive = true
        productPrice.anchor(top: nil, left: productTitle.leftAnchor, bottom: bottomAnchor, right: productTitle.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: .mediumSpace, paddingRight: 0, width: 0, height: 23)
        urgentLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 6, paddingBottom: 0, paddingRight: 0, width: 80, height: 20)
    }
    
}
