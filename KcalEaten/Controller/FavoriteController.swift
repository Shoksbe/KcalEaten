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
        _containerVew?.delegate = self
        destination.product = try? _coreDataService.fetchFavorite()
    }
    
    
    /// Get new favorite from database and reload tableview
    func updateFavorite() {
        guard let products = try? _coreDataService.fetchFavorite() else {
            return
        }
        _containerVew?.reload(products: products)
    }
}

//------------------------
//MARK: - Popup delegate
//------------------------
extension FavoriteController: PopupDelegate {
    func productHaveChange() {
        updateFavorite()
    }
    
    #warning("Afficher le pop up depuis showproductcontroller")
    func showPopUp(product: ProductObject) {
        //Lancer la page avec le produit
        let sb = UIStoryboard(name: "PopUp", bundle: nil)
        let popUp = sb.instantiateViewController(withIdentifier: "AddConsommationPopUp") as! AddConsommationPopUp
        popUp.productObject = product
        popUp.delegate = self
        self.present(popUp, animated: true)
    }
}
