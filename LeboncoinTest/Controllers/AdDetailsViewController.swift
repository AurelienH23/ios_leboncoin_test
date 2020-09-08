//
//  AdDetailsViewController.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 05/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class AdDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    let ad: Ad
    
    // MARK: View elements
    
    let scrollView = UIScrollView()
    
    lazy var productImage: OnlineImageView = {
        let iv = OnlineImageView(frame: .zero)
        if let smallImg = ad.images_url.small {
            iv.fetchImage(for: smallImg)
        } else if let thumbImg = ad.images_url.thumb {
            iv.fetchImage(for: thumbImg)
        } else {
            iv.setImageAsNotFound()
        }
        iv.layer.cornerRadius = 0
        return iv
    }()
    
    let urgentLabel = UrgentLabel(size: .regular)
    lazy var productTitle = TitleLabel(ad.title)
    lazy var category = BoldLabel(categories[ad.category_id])
    lazy var dateLabel = RegularLabel(ad.publicationDate)
    lazy var authorLabel = RegularLabel(ad.author)
    lazy var descriptionLabel = DescriptionLabel(ad.description)
    lazy var detailPriceView = DetailPrice(ad.formattedPrice)
    
    // MARK: Lifecycle
    
    init(for ad: Ad) {
        self.ad = ad
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupScrollViewContentSize()
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubviews(scrollView, detailPriceView)
        scrollView.addSubviews(productImage, urgentLabel, productTitle, category, dateLabel, authorLabel, descriptionLabel)
        
        scrollView.anchor(to: view)
        detailPriceView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        productImage.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 300)
        urgentLabel.anchor(top: nil, left: nil, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: .mediumSpace, width: 115, height: .standardTouchSpace)
        urgentLabel.centerYAnchor.constraint(equalTo: productImage.bottomAnchor).isActive = true
        productTitle.anchor(top: urgentLabel.bottomAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: 0)
        category.anchor(top: productTitle.bottomAnchor, left: productTitle.leftAnchor, bottom: nil, right: productTitle.rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        dateLabel.anchor(top: category.bottomAnchor, left: category.leftAnchor, bottom: nil, right: category.rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        authorLabel.anchor(top: dateLabel.bottomAnchor, left: dateLabel.leftAnchor, bottom: nil, right: dateLabel.rightAnchor, paddingTop: .smallSpace, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        descriptionLabel.anchor(top: authorLabel.bottomAnchor, left: authorLabel.leftAnchor, bottom: nil, right: authorLabel.rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: descriptionLabel.height)
    }
    
    fileprivate func setupScrollViewContentSize() {
        view.layoutIfNeeded()
        var contentRect = CGRect.zero
        for subview in scrollView.subviews {
            contentRect = contentRect.union(subview.frame)
        }
        scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height + 100 + .mediumSpace)
    }
    
}
