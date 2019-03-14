//
//  CoreDataHelper.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 14/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import CoreData

class CoreDataHelper {

    //------------------------
    //MARK: - ProductHelpers
    //------------------------


    /// Get all favorite product
    ///
    /// - Parameter viewContext: Contect
    /// - Returns: An array of product
    func fetchFavorite(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [ProductObject] {

        //Request
        let request: NSFetchRequest<ProductObject> = ProductObject.fetchRequest()

        //Predicate
        request.predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(ProductObject.isFavorite), NSNumber(value: true))

        //try to get favorite product
        guard let favoriteList = try? viewContext.fetch(request) else { return [] }
        return favoriteList
    }


    /// Save a product to the favorite
    ///
    /// - Parameter product: Product to make favorite
    /// - Throws: failed to save
    func addToFavorite(product: ProductObject) throws {
        product.isFavorite = true
        do {
            try AppDelegate.viewContext.save()
        } catch {
            throw CoreDataError.failedToSave
        }
    }

    /// Unsave a product to the favorite
    ///
    /// - Parameter product: Product to unmake favorite
    func removeFavorite(from product: ProductObject) throws {
        product.isFavorite = false
        do {
            try AppDelegate.viewContext.save()
        } catch {
            throw CoreDataError.failedToSave
        }
    }

    //------------------------
    //MARK: - ConsumeHelpers
    //------------------------
    func addConsume(date: Date = Date(), quantity: Int, product: ProductObject) throws {

        let consume = Consume(context: AppDelegate.viewContext)
        consume.date = date
        consume.quantity = Int32(quantity)
        consume.product = product

        do {
            try AppDelegate.viewContext.save()
        } catch {
            throw CoreDataError.failedToSave
        }
    }

}
