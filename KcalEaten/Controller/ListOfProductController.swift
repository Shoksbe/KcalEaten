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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = product?.count {
            return count
        } else if let count = productWithQuantity?.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell

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

}

//------------------------
//MARK: - Methods
//------------------------
extension ListOfProductController {
    
    /// reload tableView
    ///
    /// - Parameter products: Products to load
    func reload(products: [ProductObject]) {
        product = products
        tableview.reloadData()
    }
}
