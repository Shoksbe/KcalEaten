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
    let nutriments: Nutriments?
    let nutriScore: String?
    let brand: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name = "product_name"
        case barCode = "code"
        case nutriments
        case nutriScore = "nutrition_grades"
        case brand = "brands"
    }
}

struct Nutriments: Decodable {

    /*
     The initializer is created only to give two different types to the novaGroup variable. Sometimes this variable is String or Int.
     */
    init(from decoder: Decoder) throws {
        let contenaire = try decoder.container(keyedBy: CodingKeys.self)

        if let energy = try? contenaire.decode(String.self, forKey: .energy) {
            self.energy = energy
        } else {
            self.energy = nil
        }

        if let energyUnit = try? contenaire.decode(String.self, forKey: .energyUnit) {
            self.energyUnit = energyUnit
        } else {
            self.energyUnit = nil
        }

        if let energy100G = try? contenaire.decode(String.self, forKey: .energy100G) {
            self.energy100G = energy100G
        } else {
            self.energy100G = nil
        }

        if let novaGroup = try? contenaire.decode(String.self, forKey: .novaGroup) {
            self.novaGroup = novaGroup
        } else if let novaGroup = try? contenaire.decode(Int.self, forKey: .novaGroup) {
            self.novaGroup = novaGroup
        } else {
            novaGroup = nil
        }
    }

    let energy, energyUnit, energy100G: String?
    let novaGroup: Any?

    enum CodingKeys: String, CodingKey {
        case energy
        case energyUnit = "energy_unit"
        case energy100G = "energy_100g"
        case novaGroup = "nova-group"
    }
}
