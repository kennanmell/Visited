//
//  TabBarController.swift
//  Visited
//
//  Created by Kennan Mell on 4/7/24.
//

import UIKit

class TabBarController: UITabBarController {
    private let settings = Settings.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        var viewControllers = [UIViewController]()
        for i in 0..<MapType.all.count {
            let mapType = MapType.all[i]
            let vc = UINavigationController(
                rootViewController: MapViewController(mapType: mapType))
            vc.tabBarItem = UITabBarItem(
                title: mapType.displayName,
                image: mapType.tabBarImage,
                tag: i)
            viewControllers.append(vc)
        }

        let menuViewController = UINavigationController(
            rootViewController: UIViewController())
        menuViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Menu", comment: ""),
            image: UIImage(systemName: "ellipsis.circle"),
            tag: viewControllers.count)
        viewControllers.append(menuViewController)

        self.viewControllers = viewControllers
        selectedViewController = viewControllers[settings.selectedTab]
    }

    // MARK: UITabBarControllerDelegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        settings.selectedTab = item.tag
    }
}
