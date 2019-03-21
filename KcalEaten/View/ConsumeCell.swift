//
//  ConsumeCell.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 20/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class ConsumeCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calorieContainer: UIView!
    @IBOutlet weak var calorieLabel: VerticalAlignLabel!
    @IBOutlet weak var calorieSubtitle: VerticalAlignLabel!
    @IBOutlet weak var productContainer: UIView!
    @IBOutlet weak var quantityOfProductLabel: VerticalAlignLabel!
    @IBOutlet weak var productSubtitle: VerticalAlignLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //Corner radius
        calorieContainer.layer.cornerRadius = 5
        calorieContainer.clipsToBounds = true
        productContainer.layer.cornerRadius = 5
        productContainer.clipsToBounds = true

        //Set vertical align
        calorieLabel.verticalAlignment = .bottom
        calorieSubtitle.verticalAlignment = .top
        quantityOfProductLabel.verticalAlignment = .bottom
        productSubtitle.verticalAlignment = .top
    }

    func setup(dateString: String, countOfCalorie: Double, quantityOfProduct: Int) {
        
        calorieLabel.text = String(countOfCalorie)
        quantityOfProductLabel.text = String(quantityOfProduct)
        dateLabel.text = dateString

        calorieSubtitle.text = countOfCalorie > 1 ? "Calories" : "Calorie"
        productSubtitle.text = quantityOfProduct > 1 ? "Produits" : "Produit"
    }

}

