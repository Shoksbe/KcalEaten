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

    var product: [ProductObject]?
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
        guard let count = product?.count else { return 0 }
        return count
    }

    //Configure Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //Create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell

        //Get product a index
        guard let product = product?[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        cell.product = product

        return cell
    }

    //Size for item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberColones: CGFloat = 2
        let collectionViewInset: CGFloat = collectionView.contentInset.left + collectionView.contentInset.right
        let collectionWidth: CGFloat = collectionView.frame.width

        let itemSize = (collectionWidth - (collectionViewInset)) / numberColones
        
        return CGSize(width: itemSize, height: itemSize)
    }

    //Item did select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = self.product?[indexPath.item] {
            showPopUp(product: product)
        }
    }

}
//------------------------------
//MARK: - ProducutLayoutDelegate
//------------------------------
extension ShowProductCollectionController: ProductLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        guard let productHeight = product?[indexPath.item].image.size.height else {
            return 0
        }
        
        return productHeight
    }
}
//------------------------
//MARK: - Methods
//------------------------
extension ShowProductCollectionController {
    
    /// reload tableView
    ///
    /// - Parameter products: Products to load
    func reload(products: [ProductObject]) {
        product = products
        collectionView.reloadData()
    }
    
    func showPopUp(product: ProductObject) {
        //Lancer la page avec le produit
        let sb = UIStoryboard(name: "PopUp", bundle: nil)
        let popUp = sb.instantiateViewController(withIdentifier: "AddConsommationPopUp") as! AddConsommationPopUp
        popUp.productObject = product
        self.present(popUp, animated: true)
    }
}
