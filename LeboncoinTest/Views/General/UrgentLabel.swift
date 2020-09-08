//
//  UrgentLabel.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 07/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

enum UrgentSize {
    case small
    case regular
}

class UrgentLabel: UILabel {
    
    var size: UrgentSize
    
    init(size: UrgentSize) {
        self.size = size
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        text = "URGENT !"
        textColor = .white
        textAlignment = .center
        backgroundColor = .mainGreen
        
        switch size {
        case .small:
            layer.cornerRadius = 10
            font = .boldSystemFont(ofSize: 12)
        case .regular:
            layer.cornerRadius = .standardTouchSpace / 2
            font = .boldSystemFont(ofSize: 18)
        }
        
        clipsToBounds = true
    }
    
}
