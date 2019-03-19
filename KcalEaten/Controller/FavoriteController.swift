//
//  FavoriteController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 18/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {

    private lazy var productController: ShowProductCollectionController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        guard var viewController = storyboard.instantiateViewController(withIdentifier: "ShowProductCollectionController") as? ShowProductCollectionController else {
            return ShowProductCollectionController()
        }

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private func add(asChildViewController viewController: UIViewController) {

        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        add(asChildViewController: productController)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let product = try? CoreDataHelper().fetchFavorite()
        productController.product = product
    }
}
