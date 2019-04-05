//
//  FavoriteController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 18/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

//---------------------------
//MARK: - Variables & Outlets
//---------------------------
class FavoriteController: UIViewController {
    private let _coreDataService = CoreDataHelper()
    private let _productCellId = "productCell"
    private var _products: [ProductObject]?

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var titleView: UIView!
}

//------------------------
//MARK: - Life cycle
//------------------------
extension FavoriteController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavoriteTableview), name: .favoriteStateOfProductDidChange, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteTableview()
    }
}
//------------------------
//MARK: - Methods
//------------------------
extension FavoriteController {

    /// Get new favorite from database and reload tableview
    @objc func updateFavoriteTableview() {
        guard let products = try? _coreDataService.fetchFavorite(), !products.isEmpty else {
            titleView.isHidden = true
            return
        }
        self._products = products
        tableview.reloadData()
        titleView.isHidden = false
    }
}

//-----------------------------------------
//MARK: - Collection dataSource & Delegate
//-----------------------------------------

extension FavoriteController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = _products?.count, count > 0 {
            return count
        }
        tableView.isScrollEnabled = false
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: _productCellId, for: indexPath) as! ProductCell

        //Get product a index
        if let product = _products?[indexPath.row] {
            cell.setupProductWithConsommation(product: product)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = self._products?[indexPath.row] {
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
        if _products == nil {
            return view.bounds.height
        }
        return 0
    }

}
