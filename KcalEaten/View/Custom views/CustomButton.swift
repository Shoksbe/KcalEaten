//
//  CustomButton.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 17/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 5
    }

}
