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
        guard let count = product?.count else { return 0 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell

        //Get product a index
        guard let product = product?[indexPath.row] else {
            return UITableViewCell()
        }

        cell.product = product

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
