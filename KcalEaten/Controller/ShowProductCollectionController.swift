//
//  ShowProductCollectionController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 19/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

//---------------------------
//MARK: - Outlets & variables
//---------------------------
class ShowProductCollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    var delegate: PopupDelegate?
    var product: [ProductObject]! {
        didSet {
            collectionView.reloadData()
        }
    }
}

//------------------
//MARK: - Life Cycle
//------------------
extension ShowProductCollectionController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? ProductLayout {
            layout.delegate = self
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
    }
}
//-----------------------------------------
//MARK: - Collection dataSource & Delegate
//-----------------------------------------
extension ShowProductCollectionController {

    //Number of item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }

    //Configure Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell

        cell.product = product[indexPath.item]

        return cell
    }

    //Size for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }

    //Item did select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.product[indexPath.item]
        delegate?.showPopUp(product: product)
    }

}
//------------------------------
//MARK: - ProducutLayoutDelegate
//------------------------------
extension ShowProductCollectionController: ProductLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return product[indexPath.item].image.size.height + 40
    }
}
