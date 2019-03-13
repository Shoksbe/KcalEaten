//
//  ApiError.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 13/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case noData, failedToDecode, failedToCreateUrl, noProductFound
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failedToCreateUrl:
            return NSLocalizedString("Impossible de créer un url à partir du code barre.", comment: "")
        case .noData:
            return NSLocalizedString("Aucune données n'a pas être récupérées sur le serveur.", comment: "")
        case .failedToDecode:
            return NSLocalizedString("Impossible de décoder le fichier reçu par le serveur.", comment: "")
        case .noProductFound:
            return NSLocalizedString("Aucun produit n'as été trouvé pour ce code barre.", comment: "")
        }
    }
}
