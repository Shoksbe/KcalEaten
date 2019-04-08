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
    private let _notationCellId = "notationCell"
    private let _coreDataService = CoreDataHelper()
    var consumes: [Consume]?
}

//------------------------
//MARK: - Life Cycle
//------------------------
extension ListOfProductController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popViewController(animated: false)
    }
}

//-----------------------------------------
//MARK: - Collection dataSource & Delegate
//-----------------------------------------
extension ListOfProductController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {

        guard let consumes = consumes, !consumes.isEmpty else {
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)
            return 0
        }
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            if let count = consumes?.count,  count > 0 {
                return count
            }
        }

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: _notationCellId, for: indexPath) as! NotationCell
            return cell
        }

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let consume = self.consumes?[indexPath.row], let product = consume.product {
                SHOW_PRODUCT_PAGE(product: product, controller: self)
            }
        } else {
            performSegue(withIdentifier: "notationDetail", sender: nil)
        }

    }

    

}
