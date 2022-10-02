//
//  Button.swift
//  BicycleApp
//
//  Created by Shi Pra on 29/09/22.
//

import UIKit

class Button: UIButton {
    
    // MARK: View Properties
    let imgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .white
        return img
    }()
    
    // MARK: Properties
    let cornerRadius: CGFloat
    let imgName: String
    let outerLine: CGFloat
    
    // MARK: Initializer
    init(imgName: String, cornerRadius: CGFloat, frame: CGRect) {
        self.imgName = imgName
        self.cornerRadius = cornerRadius
        self.outerLine = 1
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle Methods
    override func draw(_ rect: CGRect) {
        self.layer.shadowRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        gradientLayerWithOutLine()
        addImage()
        clipsToBounds = false
    }
    
    // MARK: Helper Methods
    func addImage() {
        addSubview(imgView)
        imgView.image = UIImage(systemName: imgName)
        imgView.setDimensions(width: 25, height: 25)
        imgView.center(inView: self)
    }
    
    func gradientLayerWithOutLine() {
        let layer = CAShapeLayer()
        layer.path = getLayerPath(frame: CGRect(x: outerLine, y: outerLine, width: bounds.width - 2 * outerLine, height: bounds.height - 2 * outerLine), corner: cornerRadius).cgPath
        layer.fillColor = UIColor.systemBlue.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 0.204, green: 0.784, blue: 0.91, alpha: 1).cgColor,
            UIColor(red: 0.306, green: 0.29, blue: 0.949, alpha: 1).cgColor
        ]
        gradientLayer.apply(angle: 30)
        gradientLayer.mask = layer
        outlineLayer()
        self.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    func outlineLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 0.204, green: 0.784, blue: 0.91, alpha: 1).cgColor,
            UIColor(red: 0.306, green: 0.29, blue: 0.949, alpha: 1).cgColor
        ]
        gradientLayer.apply(angle: 10.0)
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = getLayerPath(frame: self.bounds, corner: 0).cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.lineWidth = 2 * cornerRadius
        gradientLayer.mask = borderLayer
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func getLayerPath(frame: CGRect, corner: CGFloat) -> UIBezierPath {
//        let offset = cornerRadius / CGFloat(2)
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: self.bounds.minX + offset, y: self.bounds.minY))
//
//        path.addLine(to: CGPoint(x: self.bounds.maxX - offset, y: self.bounds.minY))
//        path.addQuadCurve(to: CGPoint(x: self.bounds.maxX, y: self.bounds.minY + offset), controlPoint: CGPoint(x: self.bounds.maxX, y: self.bounds.minY))
//
//        path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY - offset))
//        path.addQuadCurve(to: CGPoint(x: self.bounds.maxX - offset, y: self.bounds.maxY), controlPoint: CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
//
//        path.addLine(to: CGPoint(x: self.bounds.minX + offset, y: self.bounds.maxY))
//        path.addQuadCurve(to: CGPoint(x: self.bounds.minX, y: self.bounds.maxY - offset), controlPoint: CGPoint(x: self.bounds.minX, y: self.bounds.maxY))
//
//        path.addLine(to: CGPoint(x: self.bounds.minX, y: self.bounds.minY + offset))
//        path.addQuadCurve(to: CGPoint(x: self.bounds.minX + offset, y: self.bounds.minY), controlPoint: CGPoint(x: self.bounds.minX, y: self.bounds.minY))
        
        let path = UIBezierPath(roundedRect: frame, cornerRadius: corner)
        return path
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    */

}
