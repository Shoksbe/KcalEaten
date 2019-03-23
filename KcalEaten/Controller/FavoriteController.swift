//
//  FavoriteController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 18/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

//------------------------
//MARK: - Variables
//------------------------
class FavoriteController: UIViewController {
    private let _coreDataService = CoreDataHelper()
    private var _favoritesProducts: [ProductObject]!
    private var _containerVew: ShowProductCollectionController?
}

//------------------------
//MARK: - Life cycle
//------------------------
extension FavoriteController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorite), name: .favoriteStateOfProductDidChange, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavorite()
    }
}
//------------------------
//MARK: - Methods
//------------------------
extension FavoriteController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showListOfFavorite" else { return }
        guard let destination = segue.destination as? ShowProductCollectionController else { return }
        _containerVew = destination
        destination.product = try? _coreDataService.fetchFavorite()
    }
    
    
    /// Get new favorite from database and reload tableview
    @objc func updateFavorite() {
        guard let products = try? _coreDataService.fetchFavorite() else {
            return
        }
        _containerVew?.reload(products: products)
    }
}
