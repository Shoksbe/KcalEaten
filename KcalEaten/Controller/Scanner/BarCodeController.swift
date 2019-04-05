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

class BarCodeController: MoveableController {
    
    private let _service = OpenFoodFactService()
    private let _coreDataService = CoreDataHelper()
    private let _barCodeSizeEan13 = 13
    private let _barCodeSizeEan8 = 8

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var barCode: UITextField!
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: CustomButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(container, constraint: centerConstraint)
    }
    
    override func hideKey(notification: Notification) {
        super.hideKey(notification:  notification)
        animation(0, centerConstraint)
    }
}

//------------------------
//MARK: - Life cycle
//------------------------
extension BarCodeController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
    }
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
            barCode.resignFirstResponder()
            errorLabel.text?.removeAll()
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
        
        //Count of numbers not equal to barcodeSize
        guard let barcode = barCode.text, barcode.count == _barCodeSizeEan13 || barcode.count == _barCodeSizeEan8 else {
            throw UserError.barCodeInvalide
        }
    }

    ///Get product with barcode from database or openfoodfact
    private func getProduct() {
        
        activityController.startAnimating()
        searchButton.setTitle("", for: .normal)

        //First try to get product from database

        if let productRequest = try? _coreDataService.fetchProduct(from: barCode.text!),
            let product = productRequest {
            self.activityController.stopAnimating()
            self.searchButton.setTitle("Rechercher", for: .normal)
            SHOW_PRODUCT_PAGE(product: product, controller: self)

        //If its note in database, get product from Open food fact api
        } else {
            _service.getProduct(from: barCode.text!) { (success, product, error) in
                self.activityController.stopAnimating()
                self.searchButton.setTitle("Rechercher", for: .normal)

                guard error == nil,
                    let product = product else {
                        self.errorLabel.text = error?.localizedDescription
                        return
                }
                SHOW_PRODUCT_PAGE(product: product, controller: self)

            }
        }
    }
    
}
