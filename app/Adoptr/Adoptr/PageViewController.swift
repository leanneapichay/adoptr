//
//  PageViewController.swift
//  Adoptr
//
//  Created by Leanne Pichay on 18/5/18.
//  Copyright © 2018 adoptr. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
    }
    
}
    

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}

private(set) var orderedViewControllers : [UIViewController] = {
    return  [newViewController(name: "OpeningScreen"),
             newViewController(name: "SignIn")
    ]
}()

private func newViewController(name: String) -> UIViewController {
    return UIStoryboard(name: "Main", bundle: nil) .
        instantiateViewController(withIdentifier: name)
}

