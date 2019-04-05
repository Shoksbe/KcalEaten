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

enum CoreDataError: Error {
    case failedToSave, failedToFetch
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failedToSave:
            return NSLocalizedString("Une erreure s'est produite lors de la sauvegarde.", comment: "")
        case .failedToFetch:
            return NSLocalizedString("Impossible de récupérer les éléments depuis la base de données", comment: "")
        }

    }
}

enum UserError: Error {
    case quantityToShort, quantityConversionImpossible, barCodeInvalide
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .barCodeInvalide:
            return NSLocalizedString("Mauvais code barre, il doit faire 8 ou 13 caractères.", comment: "")
        case .quantityToShort:
            return NSLocalizedString("N'oubliez pas d'entrer une quantité.", comment: "")
        case .quantityConversionImpossible:
            return NSLocalizedString("Récupération de la quantité impossible, 0 par défaut.'", comment: "")
        }
    }
}

enum ProductError: Error {
    case noName
}

extension ProductError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noName:
            return NSLocalizedString("Nom du produit inconnu", comment: "")
        }
    }
}
