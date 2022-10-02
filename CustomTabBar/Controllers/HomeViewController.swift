//
//  HomeViewController.swift
//  BicycleApp
//
//  Created by Shi Pra on 27/09/22.
//

import UIKit

class HomeViewController: DefaultViewController {
    
    // MARK: View Properties
    let navView: UIView = {
        let navView = UIView()
        return navView
    }()
    let navTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 24)
        
        title.textColor = UIColor.white
        title.text = "Home"
        return title
    }()
    lazy var searchBtn: Button = {
        let btn = Button(imgName: "magnifyingglass", cornerRadius: 10, frame: .zero)
        return btn
    }()
    
    
    // MARK: Properties
    
    // MARK: Initializer
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        super.anchorBackgroundTriangle()
        configureNavView()
        view.addSubview(navView)
        
    }
    
    override func viewWillLayoutSubviews() {
//        navTitle.center(inView: view)
        navView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, height: 60)
    }
    
    // MARK: Helper Methods
    func configureNavView() {
        navView.addSubview(navTitle)
        navView.addSubview(searchBtn)
        navTitle.centerY(inView: navView, leftAnchor: navView.leftAnchor, paddingLeft: 20)
        searchBtn.setDimensions(width: 44, height: 44)
        searchBtn.centerY(inView: navView, rightAnchor: navView.rightAnchor, paddingRight: 20)
    }
}
