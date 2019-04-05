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
    private let _coreDataService = CoreDataHelper()
    var consumes: [Consume]?
}

//-----------------------------------------
//MARK: - Collection dataSource & Delegate
//-----------------------------------------
extension ListOfProductController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = consumes?.count,  count > 0 {
            return count
        }
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: _productCellId, for: indexPath) as! ProductCell

        //Get product a index
        if let consume = consumes?[indexPath.row] {
            if let product = consume.product {
                cell.setupProductWithConsommation(product: product, quantityConsumed: Int(consume.quantity))
                return cell
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let consume = consumes?[indexPath.row] {
                try? _coreDataService.delete(consume: consume)
                consumes?.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }

}
