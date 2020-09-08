//
//  Box.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 08/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
