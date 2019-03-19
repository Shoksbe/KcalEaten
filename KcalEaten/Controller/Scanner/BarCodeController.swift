//
//  barCodeController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 16/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

//----------------------------
//MARK: - Outlets & variables
//----------------------------

class BarCodeController: UIViewController {
    
    private let _service = OpenFoodFactService()
    private let _coreDataService = CoreDataHelper()
    private let _barCodeSize = 13

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var barCode: UITextField!
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: CustomButton!
}

//------------------------
//MARK: - Life cycle
//------------------------
extension BarCodeController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorLabel.text = ""
        barCode.text = ""
    }
}

//------------------------
//MARK: - Actions
//------------------------
extension BarCodeController {
    @IBAction func searchBarCode(_ sender: Any) {
        do {
            try checkBarCode()
            errorLabel.text = ""
            getProduct()
        } catch {
            errorLabel.text = error.localizedDescription
        }
    }
}

//------------------------
//MARK: - Methods
//------------------------
extension BarCodeController {
    ///Check if the bar code is right
    private func checkBarCode() throws {
        
        //not empty
        guard let barCode = barCode.text else {
            throw UserError.barCodeToShort
        }
        
        //Count of numbers not equal to 13
        guard barCode.count == _barCodeSize else {
            if barCode.count < _barCodeSize {
                throw UserError.barCodeToShort
            } else {
                throw UserError.barCodeToLong
            }
        }
    }

    ///Get product with barcode from database or openfoodfact
    private func getProduct() {
        
        activityController.startAnimating()
        searchButton.setTitle("", for: .normal)

        if let productRequest = try? _coreDataService.fetchProduct(from: barCode.text!) {
            if let product = productRequest {
                self.activityController.stopAnimating()
                self.searchButton.setTitle("Rechercher", for: .normal)
                showProductPage(product: product)
            }
        } else {
            _service.getProduct(from: barCode.text!) { (success, product, error) in
                DispatchQueue.main.async {
                    self.activityController.stopAnimating()
                    self.searchButton.setTitle("Rechercher", for: .normal)

                    guard error == nil,
                        let product = product else {
                            self.errorLabel.text = error?.localizedDescription
                            return
                    }
                    self.showProductPage(product: product)
                }
            }
        }
    }

    /// Show propuct in a popup view
    ///
    /// - Parameter product: Wich product need to be showing
    private func showProductPage(product: ProductObject) {
        //Lancer la page avec le produit
        let sb = UIStoryboard(name: "PopUp", bundle: nil)
        let popUp = sb.instantiateViewController(withIdentifier: "AddConsommationPopUp") as! AddConsommationPopUp
        popUp.productObject = product
        self.present(popUp, animated: true)
    }
}
