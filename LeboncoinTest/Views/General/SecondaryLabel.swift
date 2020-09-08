//
//  SecondaryLabel.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 07/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class SecondaryLabel: UILabel {
    init(_ text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        textColor = .rgb(red: 0, green: 0, blue: 0, alpha: 0.5)
        font = .boldSystemFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
