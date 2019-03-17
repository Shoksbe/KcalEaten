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
    
    private var _barCodeSize = 13

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var barCode: UITextField!
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
}
