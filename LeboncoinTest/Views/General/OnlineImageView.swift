//
//  OnlineImageView.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 05/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class OnlineImageView: UIImageView {
    
    // MARK: Properties
    
    static var savedImages = [String: UIImage]()
    
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
        contentMode = .scaleAspectFill
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    func fetchImage(for imageUrl: String) {
        if let localImage = OnlineImageView.savedImages[imageUrl] {
            image = localImage
        } else {
            Network.fetchImage(urlString: imageUrl, completion: { img in
                DispatchQueue.main.async {
                    self.image = img
                }
            }) {
                self.setImageAsNotFound()
            }
        }
    }
    
    func setImageAsNotFound() {
        DispatchQueue.main.async {
            self.image = UIImage(named: "ic_no_image")?.withRenderingMode(.alwaysTemplate)
            self.tintColor = .gray
        }
    }
    
}
