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
    var productWithQuantity: [(product:ProductObject, quantity:Int)]?
}

//-----------------------------------------
//MARK: - Collection dataSource & Delegate
//-----------------------------------------
extension ListOfProductController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = productWithQuantity?.count,  count > 0 {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: _productCellId, for: indexPath) as! ProductCell

        //Get product a index
        if let product = productWithQuantity?[indexPath.row] {
            cell.setupProductWithConsommation(product: product.product, quantityConsumed: product.quantity)
        }

        return cell
    }

}
