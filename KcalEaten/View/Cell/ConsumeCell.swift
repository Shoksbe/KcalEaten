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
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //Corner radius
        calorieContainer.layer.cornerRadius = 5
        calorieContainer.clipsToBounds = true
        productContainer.layer.cornerRadius = 5
        productContainer.clipsToBounds = true
        container.layer.cornerRadius = 5
        container.clipsToBounds = true

        //Set vertical align
        calorieLabel.verticalAlignment = .bottom
        calorieSubtitle.verticalAlignment = .top
        quantityOfProductLabel.verticalAlignment = .bottom
        productSubtitle.verticalAlignment = .top
    }

    func setup(dayConsume: [Consume]) {
        
        //Date for consume
        let dateString = dayConsume.first?.date?.toString() ?? ""
        
        //calculating the total number of calories consumed for this date
        var countOfCalorie = 0.0
        dayConsume.forEach { (consume) in
            countOfCalorie += (consume.product?.kCalByGrams)! * Double(consume.quantity)
        }
        
        //calculation of the number of products consumed on this date
        var quantityOfProduct = 0
        quantityOfProduct += dayConsume.count
        
        calorieLabel.text = String(Int(countOfCalorie))
        quantityOfProductLabel.text = String(quantityOfProduct)
        dateLabel.text = dateString

        calorieSubtitle.text = countOfCalorie > 1 ? "Calories" : "Calorie"
        productSubtitle.text = quantityOfProduct > 1 ? "Produits" : "Produit"
    }

}

