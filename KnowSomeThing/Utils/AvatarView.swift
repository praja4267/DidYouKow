//
//  AvatarView.swift
//  KnowSomeThing
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import UIKit
class AvatarView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.black.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            layer.borderColor = UIColor.defaultBlue.cgColor
            layer.borderWidth = 2.0
            layer.cornerRadius = bounds.width / 2
    }
}
