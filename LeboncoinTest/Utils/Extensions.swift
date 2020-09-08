//
//  Extensions.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 04/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

extension CGFloat {
    
    // Corner radius
    /** 4 */
    static let smallCornerRadius = CGFloat(integerLiteral: 4)
    /** 8 */
    static let mediumCornerRadius = CGFloat(integerLiteral: 8)
    /** 16 */
    static let largeCornerRadius = CGFloat(integerLiteral: 16)
    /** 32 */
    static let extraLargeCornerRadius = CGFloat(integerLiteral: 32)
    
    // Spacing
    /** 8 */
    static let smallSpace = CGFloat(integerLiteral: 8)
    /** 12 */
    static let sSpace = CGFloat(integerLiteral: 12)
    /** 16 */
    static let mediumSpace = CGFloat(integerLiteral: 16)
    /** 24 */
    static let largeSpace = CGFloat(integerLiteral: 24)
    /** 32 */
    static let extraLargeSpace = CGFloat(integerLiteral: 32)
    /** 44 */
    static let standardTouchSpace = CGFloat(integerLiteral: 44)
    
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static let main = UIColor.rgb(red: 255, green: 110, blue: 20)
    static let mainGreen = UIColor.rgb(red: 73, green: 197, blue: 137)
    static let mainGray = UIColor.rgb(red: 242, green: 243, blue: 246)
    static let mainGrayTransparent = UIColor.rgb(red: 242, green: 243, blue: 246, alpha: 0.5)
    
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { (subview) in
            addSubview(subview)
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func anchor(to view: UIView) {
        anchor(top: view.topAnchor,
               left: view.leftAnchor,
               bottom: view.bottomAnchor,
               right: view.rightAnchor,
               paddingTop: 0,
               paddingLeft: 0,
               paddingBottom: 0,
               paddingRight: 0,
               width: 0,
               height: 0)
    }
    
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font as Any], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont?) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font as Any], context: nil)
        return ceil(boundingBox.width)
    }
    
}
