//
//  OpenFoodFactService.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 12/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import Foundation

class OpenFoodFactService {

    private var _task: URLSessionTask?
    private var _session = URLSession(configuration: .default)

    init(session: URLSession) {
        self._session = session
    }

    func getProduct(from barCode: String, callback: @escaping (Bool, ProductObject?, ApiError?) -> Void) {

        let urlString = "https://fr.openfoodfacts.org/api/v0/produit/\(barCode).json"

        guard let url = URL(string: urlString) else {
            callback(false, nil, ApiError.failedToCreateUrl)
            return
        }

        _task?.cancel()
        _task = _session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                //Check if data, no error and httpResponseCode is ok
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil, ApiError.noData)
                        return
                }

                //Decode jsonFiles
                guard let responseJSON = try? JSONDecoder().decode(OpenFoodFactDecodable.self, from: data) else {
                    callback(false, nil, ApiError.failedToDecode)
                    return
                }

                guard let product = self.parseData(from: responseJSON) else {
                    callback(false, nil, ApiError.noProductFound)
                    return
                }

                callback(true, product, nil)
            }
        }
        _task?.resume()
    }

    private func parseData(from data: OpenFoodFactDecodable) -> ProductObject? {

        guard data.statutsVerbose == "product found", let product = data.product else {
            return nil
        }

        //Get image data
        var imageData: Data?
        if let imageUrlString = product.imageURL {
            if let imageUrl = URL(string: imageUrlString) {
                imageData = try? Data(contentsOf: imageUrl)
            }
        }

        //Get kcalorie from kj
        var kcalByGrams = 0.0
        if let energyDouble = Double(product.nutriments.energy100G) {
            kcalByGrams = (energyDouble / 100.0) * 0.23
        }


        let productObject = ProductObject(context: AppDelegate.viewContext)
        productObject.barCode = product.barCode
        productObject.imageData = imageData
        productObject.kCalByGrams = Int32(kcalByGrams)
        productObject.name = product.name

        return productObject
    }
}
