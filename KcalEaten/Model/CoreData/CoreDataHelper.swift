//
//  CoreDataHelper.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 14/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import CoreData

class CoreDataHelper {
    
    private let _context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = AppDelegate.viewContext) {
        self._context = context
    }

    //------------------------
    //MARK: - ProductHelpers
    //------------------------

    /// Get all product
    ///
    /// - Parameter viewContext: Context
    /// - Returns: An array of product
    func fetchAllProduct() -> [ProductObject] {

        //Request
        let request: NSFetchRequest<ProductObject> = ProductObject.fetchRequest()

        //try to get product
        guard let products = try? _context.fetch(request) else { return [] }
        return products
    }


    /// Get all favorite product
    ///
    /// - Parameter viewContext: Context
    /// - Returns: An array of product
    func fetchFavorite() -> [ProductObject] {

        //Request
        let request: NSFetchRequest<ProductObject> = ProductObject.fetchRequest()

        //Predicate
        request.predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(ProductObject.isFavorite), NSNumber(value: true))

        //try to get favorite product
        guard let favoriteList = try? _context.fetch(request) else { return [] }
        return favoriteList
    }


    /// Save a product to the favorite
    ///
    /// - Parameter product: Product to make favorite
    /// - Throws: failed to save
    func addToFavorite(product: ProductObject) throws {
        product.isFavorite = true
        do {
            try _context.save()
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
            try _context.save()
        } catch {
            throw CoreDataError.failedToSave
        }
    }

    //------------------------
    //MARK: - ConsumeHelpers
    //------------------------

    
    /// Get all consume from database
    ///
    /// - Parameter viewContext: context
    /// - Returns: An array of consume
    func fetchConsume() -> [Consume] {
        let request: NSFetchRequest<Consume> = Consume.fetchRequest()
        guard let consumes = try? _context.fetch(request) else { return [] }
        return consumes
    }

    /// add a consomation to the database
    ///
    /// - Parameters:
    ///   - date: date of consomation, by default is now
    ///   - quantity: consomation's quantity
    ///   - product: wich product is consuming
    /// - Throws: If save to database fail
    func addConsume(date: Date = Date(), quantity: Int, product: ProductObject) throws {

        let consume = Consume(context: _context)
        consume.date = date
        consume.quantity = Int32(quantity)
        consume.product = product

        do {
            try _context.save()
        } catch {
            throw CoreDataError.failedToSave
        }
    }
    
    
    /// Delete consuming on database
    ///
    /// - Parameter consume: consuming to delete
    /// - Throws: If save to database fail
    func delete(consume: Consume) throws {
        _context.delete(consume)
        do {
            try _context.save()
        } catch {
            throw CoreDataError.failedToSave
        }
    }

}
