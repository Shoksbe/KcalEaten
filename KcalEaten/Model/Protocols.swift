//
//  Protocols.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 19/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

protocol PopupDelegate {
    func productHaveChange()
    func showPopUp(product: ProductObject)
}

protocol ProductLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}

