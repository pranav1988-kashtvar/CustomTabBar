//
//  DefaultViewController.swift
//  BicycleApp
//
//  Created by Shi Pra on 29/09/22.
//

import UIKit

class DefaultViewController: UIViewController {
    
    // MARK: View Properties
    lazy var backgroundView: MainViewBackground = {
        let bView = MainViewBackground()
        bView.translatesAutoresizingMaskIntoConstraints = false
        return bView
    }()
    
    // MARK: Properties
    
    // MARK: Initializer
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.141, green: 0.173, blue: 0.231, alpha: 1)
        
    }
    
    func anchorBackgroundTriangle() {
        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    // MARK: Helper Methods
}
