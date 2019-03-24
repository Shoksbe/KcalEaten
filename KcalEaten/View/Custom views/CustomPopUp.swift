//
//  CustomPopUp.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 17/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class CustomPopUp: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -10, height: 10)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
    }
}
