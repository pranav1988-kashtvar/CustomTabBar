//
//  SelectedLayer.swift
//  BicycleApp
//
//  Created by Shi Pra on 28/09/22.
//

import UIKit

class SelectedLayer: CALayer {
    
    let transparentPart: CGFloat = 20
    let cornorRadius: CGFloat = 5
    let lineWidth: CGFloat = 4
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    override init() {
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    func backgroundLayerPath() -> UIBezierPath {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0 + lineWidth, y: transparentPart + lineWidth))
//        path.addLine(to: CGPoint(x: bounds.maxX - lineWidth, y: 0 + lineWidth))
//        path.addLine(to: CGPoint(x: bounds.maxX - lineWidth, y: bounds.maxY - transparentPart - lineWidth))
//        path.addLine(to: CGPoint(x: 0 + lineWidth, y: bounds.maxY - lineWidth))
//        path.close()
//        return path
//    }

    func backgroundLayerPath() -> UIBezierPath {
        let offset = cornorRadius / 2
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: transparentPart + cornorRadius))
        path.addQuadCurve(to: CGPoint(x: cornorRadius, y: transparentPart - offset), controlPoint: CGPoint(x: 0, y: transparentPart))
        path.addLine(to: CGPoint(x: bounds.maxX - cornorRadius, y: offset))
        path.addQuadCurve(to: CGPoint(x: bounds.maxX, y: transparentPart - offset), controlPoint: CGPoint(x: bounds.maxX, y: offset))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - transparentPart - cornorRadius))
        path.addQuadCurve(to: CGPoint(x: bounds.maxX - cornorRadius, y: bounds.maxY - transparentPart + offset), controlPoint: CGPoint(x: bounds.maxX, y: bounds.maxY - transparentPart))
        path.addLine(to: CGPoint(x: cornorRadius, y: bounds.maxY - offset - 1))
        path.addQuadCurve(to: CGPoint(x: 0, y: bounds.maxY - cornorRadius), controlPoint: CGPoint(x: 2, y: bounds.maxY - offset))
        path.close()


        return path
    }
    
    func gradiantLayer() {
        let layer = CAShapeLayer()
        layer.path = backgroundLayerPath().cgPath
        layer.fillColor = UIColor.systemBlue.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [
            UIColor(red: 52/255, green: 200/255, blue: 232/255, alpha: 1).cgColor,
            UIColor(red: 78/255, green: 74/255, blue: 242/255, alpha: 1).cgColor
        ]
        gradientLayer.apply(angle: 60)
        gradientLayer.mask = layer
        
        self.insertSublayer(gradientLayer, at: 1)
    }
    
    public func addGradientBorder() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: self.bounds.size)
        gradientLayer.colors = [
            UIColor(red: 52/255, green: 200/255, blue: 232/255, alpha: 1).cgColor,
            UIColor(red: 78/255, green: 74/255, blue: 242/255, alpha: 1).cgColor
        ]
        gradientLayer.apply(angle: 10.0)
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = backgroundLayerPath().cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.lineWidth = lineWidth
        gradientLayer.mask = borderLayer
        self.insertSublayer(gradientLayer, at: 0)
    }
    
}
