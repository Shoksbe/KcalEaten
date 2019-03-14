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

    //Get favorite
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
}
