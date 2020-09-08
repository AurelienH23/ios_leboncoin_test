//
//  ErrorCell.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 07/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

protocol ErrorCellDelegate {
    func refreshAds()
}

class ErrorCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var delegate: ErrorCellDelegate?
    
    // MARK: View elements
    
    let titleLabel: TitleLabel = {
        let label = TitleLabel("Une erreur est survenue. Vérifiez votre connexion internet et réessayez.")
        label.textAlignment = .center
        return label
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rafraichir", for: .normal)
        button.setTitleColor(UIColor(named: "buttonTitleColor"), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(named: "backgroundLightColor")
        button.layer.cornerRadius = .mediumCornerRadius
        button.addTarget(self, action: #selector(didSelectRefreshButton), for: .touchUpInside)
        return button
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
        let stack = UIStackView(arrangedSubviews: [titleLabel, refreshButton])
        stack.axis = .vertical
        stack.spacing = .mediumSpace
        
        addSubviews(stack)
        
        stack.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: .largeSpace, paddingBottom: 0, paddingRight: .largeSpace, width: 0, height: 0)
        stack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: .standardTouchSpace).isActive = true
    }
    
    @objc fileprivate func didSelectRefreshButton() {
        delegate?.refreshAds()
    }
    
}
