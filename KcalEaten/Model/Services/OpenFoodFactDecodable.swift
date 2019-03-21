//
//  OpenFoodFactDecodable
//  KcalEaten
//
//  Created by Gregory De knyf on 12/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

struct OpenFoodFactDecodable: Decodable {
    let product: Product?
    let statutsVerbose: String

    enum CodingKeys: String, CodingKey {
        case product
        case statutsVerbose = "status_verbose"
    }
}

struct Product: Decodable {
    let imageURL: String?
    let name: String
    let barCode: String
    let nutriments: Nutriments

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name = "product_name"
        case barCode = "code"
        case nutriments
    }
}

struct Nutriments: Decodable {
    let energy, energyUnit, energy100G: String

    enum CodingKeys: String, CodingKey {
        case energy
        case energyUnit = "energy_unit"
        case energy100G = "energy_100g"
    }
}
