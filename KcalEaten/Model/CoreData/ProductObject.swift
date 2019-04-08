//
//  Product.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 12/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import CoreData
import UIKit

class ProductObject: NSManagedObject {

    var image: UIImage {

        guard let data = self.imageData, let img = UIImage(data: data) else {
            return UIImage()
        }
        
        return img

    }
}
