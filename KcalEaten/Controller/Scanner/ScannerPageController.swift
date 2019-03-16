//
//  ScannerPageController.swift
//  KcalEaten
//
//  Created by Gregory De knyf on 16/03/2019.
//  Copyright © 2019 Gregory De knyf. All rights reserved.
//

import UIKit

class ScannerPageController: UIPageViewController {
    
    private lazy var subViewController: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CameraController") as! CameraController,
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BarCodeController") as! BarCodeController
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewController[0]], direction: .forward, animated: true, completion: nil)
    }

}

extension ScannerPageController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewController.index(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return subViewController[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewController.index(of: viewController) ?? 0
        if currentIndex >= subViewController.count - 1 {
            return nil
        }
        return subViewController[currentIndex + 1]
    }
    
    
}
