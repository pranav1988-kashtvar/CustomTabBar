//
//  MainViewBackground.swift
//  BicycleApp
//
//  Created by Shi Pra on 27/09/22.
//

import UIKit

class MainViewBackground: UIView {
    
    // MARK: View Properties
    
    // MARK: Properties
    var isSetup: Bool = false
    let xOffsetPercent = 75
    let yOffsetPercent = 10
    let increasedHeightBy:CGFloat = 0
    let negativexOffset: CGFloat = 0
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    // MARK: Lifecycle Methods
    override func layoutSubviews() {
        if !isSetup {
            setup()
            isSetup = true
        }
        super.layoutSubviews()
    }
    
    // MARK: Helper Methods
    func initialConfig(){
        self.backgroundColor = .clear
    }
    
    func backgroundShapeLayer() -> UIBezierPath {
        let path = UIBezierPath()
        let xOffset = (bounds.size.width * CGFloat(xOffsetPercent)) / 100
        let yOffset = (bounds.size.height * CGFloat(yOffsetPercent)) / 100
        
        path.move(to: CGPoint(x: xOffset, y: 0))
        path.addLine(to: CGPoint(x: bounds.maxX, y: yOffset))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY + increasedHeightBy))
        path.addLine(to: CGPoint(x: -negativexOffset, y: bounds.maxY + increasedHeightBy))
        
        path.close()
        return path
    }
    
    func setup() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.position = CGPoint(x: 0, y: 0)
        shapeLayer.path = backgroundShapeLayer().cgPath
        let layer0 = CAGradientLayer()
        layer0.frame = self.bounds
        
        layer0.colors = [
          UIColor(red: 0.216, green: 0.714, blue: 0.914, alpha: 1).cgColor,
          UIColor(red: 0.294, green: 0.298, blue: 0.929, alpha: 1).cgColor

        ]

        layer0.mask = shapeLayer
        self.layer.addSublayer(layer0)
    }
}
