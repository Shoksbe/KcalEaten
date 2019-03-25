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
    private let _barCodeSize = 13

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

        if let productRequest = try? _coreDataService.fetchProduct(from: barCode.text!),
            let product = productRequest {
            self.activityController.stopAnimating()
            self.searchButton.setTitle("Rechercher", for: .normal)
            SHOW_PRODUCT_PAGE(product: product, controller: self)
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
