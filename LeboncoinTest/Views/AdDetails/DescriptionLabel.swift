//
//  DescriptionLabel.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 06/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class DescriptionLabel: UIView {
    
    // MARK: Properties
    
    var height: CGFloat {
        return getHeight()
    }
    
    // MARK: View elements
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroundLightColor")
        view.layer.cornerRadius = .largeCornerRadius
        return view
    }()
    
    let textLabel = RegularLabel()
        
    let questionMark: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .mainGray
        label.layer.cornerRadius = .standardTouchSpace / 2
        label.clipsToBounds = true
        label.layer.borderWidth = 4
        label.layer.borderColor = UIColor(named: "backgroundColor")?.cgColor
        return label
    }()
    
    // MARK: Lifecycle
    
    init(_ text: String) {
        super.init(frame: .zero)
        textLabel.text = text
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    fileprivate func setupViews() {
        addSubviews(backView, textLabel, questionMark)
        
        backView.anchor(top: questionMark.centerYAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        textLabel.anchor(top: questionMark.bottomAnchor, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, paddingTop: .mediumSpace, paddingLeft: .mediumSpace, paddingBottom: .mediumSpace, paddingRight: .mediumSpace, width: 0, height: 0)
        questionMark.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: .standardTouchSpace, height: .standardTouchSpace)
        questionMark.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    fileprivate func getHeight() -> CGFloat {
        let textHeight = textLabel.text?.height(withConstrainedWidth: UIScreen.main.bounds.width - 3 * .extraLargeSpace, font: textLabel.font) ?? 20
        return .standardTouchSpace + .mediumSpace + textHeight + .mediumSpace
    }
    
}
