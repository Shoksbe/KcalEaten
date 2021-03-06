//
//  CoreDataTest.swift
//  KcalEatenTests
//
//  Created by Gregory De knyf on 14/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import XCTest
import CoreData
@testable import KcalEaten

class CoreDataTest: XCTestCase {

    //------------------------
    //MARK: - Properties
    //------------------------
    
    lazy var mockContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "KcalEaten")
        container.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: { (description, error) in
            XCTAssertNil(error)
        })
        return container
    }()
    
    //------------------------
    //MARK: - Helpers methods
    //------------------------
    
    private func createProduct(quantity: Int, into context: NSManagedObjectContext) -> [ProductObject] {
        var products = [ProductObject]()
        for i in 0 ..< quantity {
            let newProduct = ProductObject(context: context)
            newProduct.barCode = "\(i)"
            newProduct.kCalByGrams = 10
            newProduct.name = "Test product"
            products.append(newProduct)
        }
        return products
    }
    
    private func addFavorite(quantity: Int, into context: NSManagedObjectContext) {
        let products = createProduct(quantity: 5, into: context)
        products.forEach { (product) in
            try? CoreDataHelper(context: context).addToFavorite(product: product)
        }
    }
    
    //------------------------
    //MARK: - Consume
    //------------------------
    
    func testGivenManyConsumeWhenTrySaveThenNoError() {
        
        //Background context
        let backgroundContext = mockContainer.newBackgroundContext()
        
        //Creating products
        let products = createProduct(quantity: 10, into: backgroundContext)
        
        //Foreach products add consume
        products.forEach { (product) in
            XCTAssertNoThrow(try? CoreDataHelper(context: backgroundContext).addConsume(quantity: 100, product: product))
        }
        
    }
    
    func testGiven10ConsumeWhenGetCountThenCountEqual10() {
        
        //Background context
        let context = mockContainer.viewContext
        
        //Creating products
        let products = createProduct(quantity: 10, into: context)
        
        //Foreach products add consume
        products.forEach { (product) in
            XCTAssertNoThrow(try? CoreDataHelper(context: context).addConsume(quantity: 100, product: product))
        }

        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchConsume())
        let consumes = try! CoreDataHelper(context: context).fetchConsume()
        
        XCTAssertEqual(10, consumes.count)
        
    }
    
    func testGiven10ConsumeWhenDelete1ConsumeThenCountOfConsumeEqual9() {
        
        // context
        let context = mockContainer.viewContext
        
        //Creating products
        let products = createProduct(quantity: 10, into: context)
        
        //Foreach products add consume
        products.forEach { (product) in
            XCTAssertNoThrow(try? CoreDataHelper(context: context).addConsume(quantity: 100, product: product))
        }
        
        //Get consumes (10)
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchConsume())
        var consumes = try! CoreDataHelper(context: context).fetchConsume()
        
        //Delete 1 consume
        XCTAssertNoThrow(try? CoreDataHelper(context: context).delete(consume: consumes[0]))
        
        //Get consumes (9)
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchConsume())
        consumes = try! CoreDataHelper(context: context).fetchConsume()

        XCTAssertEqual(9, consumes.count)
        
    }

    //------------------------
    //MARK: - Product
    //------------------------

    func testGivenAProductWhenGetProductThenResultIsNotNil() {

        let context = mockContainer.viewContext

        //Given
        addFavorite(quantity: 1, into: context)

        //When
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchProduct(from: "0"))
        let product = try! CoreDataHelper(context: context).fetchProduct(from: "0")

        //Then
        XCTAssertNotNil(product)
    }

    func testGivenNoProductWhenGetProductThenResultIsNotNil() {

        let context = mockContainer.viewContext

        //Given

        //When
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchProduct(from: "0"))
        let product = try! CoreDataHelper(context: context).fetchProduct(from: "0")

        //Then
        XCTAssertNil(product)
    }

    //------------------------
    //MARK: - Favorite
    //------------------------
    
    func testGiven0FavoriteWhenGetCountThenCountEqual0() {
        XCTAssertNoThrow(try? CoreDataHelper(context: mockContainer.viewContext).fetchFavorite())
        let favorites = try! CoreDataHelper(context: mockContainer.viewContext).fetchFavorite()
        XCTAssertEqual(0, favorites.count)
    }
    
    func testGiven0FavoritesWhenAdd5FavoriteThenCountEqual5() {
        //Given
        
        //When
        let context = mockContainer.viewContext
        addFavorite(quantity: 5, into: context)
        
        //Then
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchFavorite())
        let favorites = try! CoreDataHelper(context: context).fetchFavorite()
        
        XCTAssertEqual(5, favorites.count)
    }
    
    func testGiven5FavoritesWhenDelete1ThenCountEqual4() {
        
        var favorites: [ProductObject]
        
        //Given
        let context = mockContainer.viewContext
        addFavorite(quantity: 5, into: context)
        
        //When
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchFavorite())
        favorites = try! CoreDataHelper(context: context).fetchFavorite()
        XCTAssertEqual(5, favorites.count)
        
        XCTAssertNoThrow(try? CoreDataHelper(context: context).removeFavorite(from: favorites[0]))

        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchFavorite())
        favorites = try! CoreDataHelper(context: context).fetchFavorite()
        XCTAssertEqual(4, favorites.count)

    }

    func testIfProductItsNotDuplicateWhenIsManipulating() {

        let context = mockContainer.viewContext
        var allProducts = [ProductObject]()
        let product = createProduct(quantity: 1, into: context)[0]
        print(allProducts.count)


        XCTAssertNoThrow(try? CoreDataHelper(context: context).addToFavorite(product: product))
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchAllProduct())
        allProducts = try! CoreDataHelper(context: context).fetchAllProduct()
        XCTAssertEqual(1, allProducts.count)

        XCTAssertNoThrow(try? CoreDataHelper(context: context).removeFavorite(from: product))
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchAllProduct())
        allProducts = try! CoreDataHelper(context: context).fetchAllProduct()
        XCTAssertEqual(1, allProducts.count)

        XCTAssertNoThrow(try? CoreDataHelper(context: context).addConsume(quantity: 100, product: product))
        XCTAssertNoThrow(try? CoreDataHelper(context: context).fetchAllProduct())
        allProducts = try! CoreDataHelper(context: context).fetchAllProduct()
        XCTAssertEqual(1, allProducts.count)

    }
}
