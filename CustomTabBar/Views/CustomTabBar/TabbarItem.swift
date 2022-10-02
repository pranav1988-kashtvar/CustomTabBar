//
//  TabbarItem.swift
//  BicycleApp
//
//  Created by Shi Pra on 27/09/22.
//

import UIKit

class TabbarItem: UIView {

    // MARK: View Properties
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor.white
        image.image = self.image
        return image
    }()
    // MARK: Properties
    var image: UIImage
    var imageCenterYConstraint : NSLayoutConstraint?
    var selected: Bool = false
    
    // MARK: Initializer
    init(frame: CGRect, tabBarItem: UITabBarItem, selected: Bool) {
        
        guard let selecteImage = tabBarItem.image else {
            fatalError("You should set image to all view controllers")
        }
        self.image = selecteImage.withRenderingMode(.alwaysTemplate)
        self.selected = selected
        super.init(frame: frame)
        setup()
        isUserInteractionEnabled = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: Lifecycle Methods
    
    // MARK: Helper Methods
    func setup() {
        self.addSubview(imageView)
//        imageView.image = image
        imageView.centerX(inView: self)
        imageView.setDimensions(width: 25, height: 25)
        imageCenterYConstraint = imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: selected ? -20 : 0)
        imageCenterYConstraint?.isActive = true
    }
    
    func animateSelectedImageView() {
        imageCenterYConstraint?.constant = -20
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    func animateDeselectImage() {
        imageCenterYConstraint?.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}
