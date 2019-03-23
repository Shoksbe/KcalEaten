//
//  AddConsommationPopUp.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 17/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

//----------------------------
//MARK: - Outlets & variables
//----------------------------
class AddConsommationPopUp: UIViewController {

    var productObject: ProductObject?
    private var _product: ProductObject!
    private let _service = CoreDataHelper()

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
}

//------------------------
//MARK: - Actions
//------------------------
extension AddConsommationPopUp {
    
    @IBAction func favoriteButtonDidTap(_ sender: Any) {
        toggleFavoriteIcon()
    }
    
    @IBAction func cancerDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addDidTap(_ sender: Any) {
        do {
            let quantity = try checkQuantityTextField()
            try _service.addConsume(quantity: quantity, product: _product)
            dismiss(animated: true, completion: nil)
        } catch {
            errorLabel.text = error.localizedDescription
        }
    }
}

//------------------------
//MARK: - Life cycles
//------------------------
extension AddConsommationPopUp {
    override func viewDidLoad() {
        super.viewDidLoad()
        if productObject != nil {
            _product = productObject!
        } else {
            dismiss(animated: true, completion: nil)
        }
        updateViewWithProductData()
    }
}

//------------------------
//MARK: - Methods
//------------------------
extension AddConsommationPopUp {
    private func updateViewWithProductData() {
        
        //Check if product is already a favorite
        if _product.isFavorite {
            favoriteButton.setImage(FAVORITE_ON , for: .normal)
        } else {
            favoriteButton.setImage(FAVORITE_OFF , for: .normal)
        }
        
        //Check image for product
        productImage.image = _product.image
        
        //Check title product
        if let productName = _product.name {
            articleTitle.text = productName
        } else {
            articleTitle.text = ProductError.noName.localizedDescription
        }
    }
    
    private func toggleFavoriteIcon() {
        
        if _product.isFavorite {
            do {
                try _service.removeFavorite(from: _product)
                favoriteButton.setImage(FAVORITE_OFF , for: .normal)
            } catch {
                errorLabel.text = error.localizedDescription
            }
        } else {
            do {
                try _service.addToFavorite(product: _product)
                favoriteButton.setImage(FAVORITE_ON , for: .normal)
            } catch {
                errorLabel.text = error.localizedDescription
            }
        }

        NotificationCenter.default.post(name: .favoriteStateOfProductDidChange, object: nil)
    }
    
    private func checkQuantityTextField() throws -> Int {
        guard let quantityString = quantityTextField.text,
            quantityString.count > 0 else {
            throw UserError.quantityToShort
        }
        
        guard let quantityInt = Int(quantityString) else {
            throw UserError.quantityConversionImpossible
        }
        
        return quantityInt
    }
}
