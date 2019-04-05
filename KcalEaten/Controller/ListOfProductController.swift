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
class ListOfProductController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    private let _productCellId = "productCell"
    var product: [ProductObject]?
    var productWithQuantity: [(product:ProductObject, quantity:Int)]?
}

//------------------
//MARK: - Life Cycle
//------------------
extension ListOfProductController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//-----------------------------------------
//MARK: - Collection dataSource & Delegate
//-----------------------------------------

extension ListOfProductController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = product?.count, count > 0 {
            return count
        } else if let count = productWithQuantity?.count,  count > 0 {
            return count
        }
        
        tableView.isScrollEnabled = false
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: _productCellId, for: indexPath) as! ProductCell

        //Get product a index
        if let product = productWithQuantity?[indexPath.row] {
            cell.setupProductWithConsommation(product: product.product, quantityConsumed: product.quantity)
        } else if let product = product?[indexPath.row] {
            cell.setupProductWithConsommation(product: product)
        }


        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = self.product?[indexPath.row] {
            SHOW_PRODUCT_PAGE(product: product, controller: self)
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //Setup container
        let container = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))

        //Setup imageView
        let imageViewWidthAndHeigth: CGFloat = container.frame.width * 0.5
        let imageView = UIImageView(frame: CGRect(x: imageViewWidthAndHeigth / 2, y: (container.frame.height / 2) - imageViewWidthAndHeigth, width: imageViewWidthAndHeigth, height: imageViewWidthAndHeigth))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "NoFavorite")

        //Setup Label
        let topMarginToImageView: CGFloat = 10
        let label = UILabel(frame: CGRect(x: imageView.frame.minX, y: imageView.frame.maxY + topMarginToImageView, width: imageViewWidthAndHeigth, height: 0))
        label.text = "Vous n'avez encore aucun favoris, scannez un produit afin de pouvoir ajouter un favoris."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()

        //Add subview
        container.addSubview(imageView)
        container.addSubview(label)

        return container
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if product == nil && productWithQuantity == nil {
            return view.bounds.height
        }
        return 0
    }

}

//------------------------
//MARK: - Methods
//------------------------
extension ListOfProductController {
    
    /// reload tableView
    ///
    /// - Parameter products: Products to load
    func reloadTableview(with products: [ProductObject]?) {
        product = products
        tableview.reloadData()
    }
}
