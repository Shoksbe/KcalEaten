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
    private let _showListOfFavoriteSegueId = "showListOfFavorite"
    private let _coreDataService = CoreDataHelper()
    ///is used to reload the tableview on ListOfProductController
    private var _containerView: ListOfProductController?

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleView: UIView!
}

//------------------------
//MARK: - Life cycle
//------------------------
extension FavoriteController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == _showListOfFavoriteSegueId else { return }
        guard let destination = segue.destination as? ListOfProductController else { return }
        guard let product = try? _coreDataService.fetchFavorite() else { return }
        destination.product = product.isEmpty ? nil : product

        _containerView = destination
    }
    
    
    /// Get new favorite from database and reload tableview
    @objc func updateFavoriteTableview() {
        guard let products = try? _coreDataService.fetchFavorite(), !products.isEmpty else {
            _containerView?.reloadTableview(with: nil)
            titleView.isHidden = true
            return
        }
        titleView.isHidden = false
        _containerView?.reloadTableview(with: products)
    }
}
