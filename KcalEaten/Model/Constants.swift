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
let DATE_FORMAT: String = "d MMMM yyyy"
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


/// Show a popup with an error description
///
/// - Parameters:
///   - errorDescription: The string description of an error
///   - controller: which controller call the popup
func SHOW_FAIL_POPUP(errorDescription: String, controller: UIViewController) {
    //Lancer la page avec le produit
    let sb = UIStoryboard(name: "PopUp", bundle: nil)
    let popUp = sb.instantiateViewController(withIdentifier: "FailPopup") as! FailPopUp
    popUp.errorDescription = errorDescription
    controller.present(popUp, animated: true)
}
