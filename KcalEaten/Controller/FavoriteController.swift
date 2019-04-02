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
    private var _containerVew: ShowProductCollectionController?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleView: UIView!
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
        guard let product = try? _coreDataService.fetchFavorite() else { return }
        destination.product = product
    }
    
    
    /// Get new favorite from database and reload tableview
    @objc func updateFavorite() {
        guard let products = try? _coreDataService.fetchFavorite(),
                  !products.isEmpty else {
            containerView.isHidden = true
            titleView.isHidden = true
            return
        }
        titleView.isHidden = false
        containerView.isHidden = false
        _containerVew?.reload(products: products)
    }
}
