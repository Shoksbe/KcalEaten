//
//  Constants.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 17/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

let FAVORITE_ON: UIImage = UIImage(named: "favoriteOn")!
let FAVORITE_OFF: UIImage = UIImage(named: "favoriteOff")!
let DATE_FORMAT: String = "d MMM yyyy"
let LOCAL: Locale = Locale(identifier: "fr_BE")

/// Show propuct in a popup view
///
/// - Parameter product: Wich product need to be showing
func SHOW_PRODUCT_PAGE(product: ProductObject, controller: UIViewController) {
    //Lancer la page avec le produit
    let sb = UIStoryboard(name: "PopUp", bundle: nil)
    let popUp = sb.instantiateViewController(withIdentifier: "AddConsommationPopUp") as! AddConsommationPopUp
    popUp.productObject = product
    controller.present(popUp, animated: true)
}
