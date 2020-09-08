//
//  DetailPrice.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 07/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class DetailPrice: UIView {
    
    // MARK: Properties
    
    let price: String
    
    // MARK: View elements
    
    let backView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        
    lazy var priceTag: UILabel = {
        let label = UILabel()
        label.text = price
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        label.backgroundColor = .main
        label.layer.cornerRadius = .standardTouchSpace / 2
        label.clipsToBounds = true
        return label
    }()
    
    let cartBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Ajouter au panier", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = .standardTouchSpace / 2
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1
        btn.alpha = 0.3
        return btn
    }()
    
    // MARK: Lifecycle
    
    init(_ price: String) {
        self.price = price
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        addSubviews(backView, priceTag, cartBtn)
        
        backView.anchor(to: self)
        let priceWidth = price.width(withConstrainedHeight: .standardTouchSpace, font: priceTag.font) + 2 * .mediumSpace
        priceTag.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: 0, width: priceWidth, height: .standardTouchSpace)
        cartBtn.anchor(top: topAnchor, left: priceTag.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: 0, paddingRight: .mediumSpace, width: 0, height: .standardTouchSpace)
    }
    
}
