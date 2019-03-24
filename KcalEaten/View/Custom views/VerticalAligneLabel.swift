//
//  VerticalAlignLabel.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 21/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

public class VerticalAlignLabel: UILabel {
    enum VerticalAlignment {
        case top
        case middle
        case bottom
    }

    var verticalAlignment : VerticalAlignment = .top {
        didSet {
            setNeedsDisplay()
        }
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: limitedToNumberOfLines)

        switch verticalAlignment {
        case .top:
            return CGRect(x: rect.origin.x, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
        case .middle:
            return CGRect(x: rect.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height)
        case .bottom:
            return CGRect(x: rect.origin.x, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height)
        }
    }

    override public func drawText(in rect: CGRect) {
        let r = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: r)
    }
}
