//
//  ViewController.swift
//  BicycleApp
//
//  Created by Shi Pra on 27/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    // MARK: View Properties
    let tabView: TabbarView = {
        let tabView = TabbarView()
        tabView.translatesAutoresizingMaskIntoConstraints = false
        return tabView
    }()
    let containerView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor.systemRed
        return content
    }()
    // MARK: Properties
    var selectedIndex: Int = 0
    var previousSelected: Int = 0
    
    // CHANGE TOP BAR COLOR TO WHITE (TIME AND BATTERY)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Initializer
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        view.addSubview(tabView)
        setupTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        containerView.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor)
        tabView.anchor(left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, height: 100)
    }
    
    // MARK: Helper Methods
    func setupTabBar() {
        let controller1 = HomeViewController()
        let controller2 = SearchViewController()
        let controller3 = ProfileViewController()
        let controller4 = HomeViewController()
        let controller5 = SearchViewController()
        controller1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        controller2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 1)
        controller3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "books.vertical.fill"), tag: 2)
        controller4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 3)
        controller5.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: 3)
        tabView.viewControllers = [controller1, controller2, controller3, controller4, controller5]
        tabView.delegate = self
    }
}

// MARK: Tabbar Delegate Implement
extension ViewController: TabbarDelegate {
    
    func tabBar(_ tabBar: TabbarView, didSelectTabAt index: Int) {
        let previousVC = tabView.viewControllers[previousSelected]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        previousSelected = selectedIndex
        
        let vc = tabView.viewControllers[index]
        addChild(vc)
        selectedIndex = index
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}
