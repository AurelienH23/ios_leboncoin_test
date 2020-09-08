//
//  BoldLabel.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 07/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class BoldLabel: UILabel {
    init(_ text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        font = .boldSystemFont(ofSize: 18)
        textColor = .main
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
