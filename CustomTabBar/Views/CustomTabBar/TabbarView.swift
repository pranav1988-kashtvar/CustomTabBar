//
//  TabbarView.swift
//  BicycleApp
//
//  Created by Shi Pra on 27/09/22.
//

import UIKit

protocol TabbarDelegate: AnyObject {
    func tabBar(_ tabBar: TabbarView, didSelectTabAt index: Int)
}
class TabbarView: UIView {
    
    // MARK: Properties
    let numberOfTabs = 5
    let selectedLayerYOffset: CGFloat = 20
    var margin: CGFloat = 20
    var selectedViewWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    var initialAnimation: Bool = false
    var previousSelectedIndex = 0
    var selectedIndex = 0 {
        didSet {
            animateTabItem(index: selectedIndex)
        }
    }
    var tabItemFrame: [CGRect] = []
    let leftOffsetForBackgroundRectPercentage = 28
    var isSetup: Bool = false
    var viewControllers = [UIViewController]() {
        didSet {
            guard !viewControllers.isEmpty else { return }
            
            DispatchQueue.main.async {
                self.drawTabs()
                self.didSelectTab(index: 0)
            }
        }
    }
    var delegate: TabbarDelegate? 
    
    // MARK: View Properties
    var selectedLayer: SelectedLayer!
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle Methods
    override func draw(_ rect: CGRect) {
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = backgroundShapeLayer().cgPath
        self.layer.shadowOpacity = 0.5
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        let tabWidth = selectedViewWidth / CGFloat(numberOfTabs)
        let index = Int(floor(touchArea / tabWidth))
        
        didSelectTab(index: index)
    }
    
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
    
    func setup() {
        gradientLayer()
    }   
    
    func backgroundShapeLayer() -> UIBezierPath {
        let path = UIBezierPath()
        let yOffset = (bounds.size.height * CGFloat(leftOffsetForBackgroundRectPercentage)) / 100
        
        path.move(to: CGPoint(x: bounds.maxX, y: 0))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: 0, y: bounds.maxY))
        path.addLine(to: CGPoint(x: 0, y: yOffset))
 
        path.close()
        return path
    }
    
    func gradientLayer() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = backgroundShapeLayer().cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.type = .radial
        
        gradientLayer.colors = [
            UIColor(red: 39/255, green: 47/255, blue: 77/255, alpha: 1).cgColor,
            UIColor(red: 45/255, green: 53/255, blue: 106/255, alpha: 1).cgColor
        ]
        gradientLayer.apply(angle: 45)
        gradientLayer.mask = shapeLayer
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: Add tab bar item
extension TabbarView {
    func drawTabs() {
        for(index, _) in viewControllers.enumerated() {
            let x = selectedViewWidth * CGFloat(index) / CGFloat(numberOfTabs)
            let y: CGFloat = 0
            let width = selectedViewWidth / CGFloat(numberOfTabs)
            let frame = CGRect(x: x, y: y, width: width, height: self.frame.size.height)
            tabItemFrame.append(frame)
        }
        getSelectedLayer(frame: tabItemFrame[0])
        
        self.layer.addSublayer(selectedLayer)
        for(index, vc) in viewControllers.enumerated() {
            let barView = TabbarItem(frame: tabItemFrame[index], tabBarItem: vc.tabBarItem, selected: index == 0)
            tabItemFrame.append(frame)
            self.addSubview(barView)
        }
    }
    
    func getSelectedLayer(frame: CGRect) {
        selectedLayer = SelectedLayer()
        let width = (selectedViewWidth * 4 / CGFloat(numberOfTabs * numberOfTabs))
        let xPosition = (frame.size.width - width) / 2
        
        selectedLayer.frame = CGRect(x: xPosition, y: 0, width: width, height: width)
        selectedLayer.gradiantLayer()
        selectedLayer.addGradientBorder()
        selectedLayer.shadowRadius = 5
        selectedLayer.shadowColor = UIColor.black.cgColor
        selectedLayer.shadowPath = selectedLayer.backgroundLayerPath().cgPath
        selectedLayer.shadowOpacity = 0.5
        
    }
    
    func didSelectTab(index: Int) {
        delegate?.tabBar(self, didSelectTabAt: index)
        if index == selectedIndex {return}
        
        previousSelectedIndex = selectedIndex
        selectedIndex  = index
        animateTabItem(index: index)
        animateLayer()
    }
}

// MARK: Animation Layer
extension TabbarView {
    func animateTabItem(index: Int) {
        if(initialAnimation) {
            self.subviews.enumerated().forEach {
                guard let tabview = $1 as? TabbarItem else {return}
                $0 == index ? tabview.animateSelectedImageView() : tabview.animateDeselectImage()
            }
        }else {
            if let tabView = self.subviews.first as? TabbarItem {
                tabView.animateSelectedImageView()
                initialAnimation = true
            }
        }
        
    }
    
    func animateLayer() {
        let tabItemFrameSelected = tabItemFrame[selectedIndex]
        let previousFrame = tabItemFrame[previousSelectedIndex]
        let startX:CGFloat = (previousFrame.minX + previousFrame.maxX)/CGFloat(2)
        let endX: CGFloat = (tabItemFrameSelected.minX + tabItemFrameSelected.maxX)/CGFloat(2)
        
        animateShapeSpring(startX: startX, endX: endX)
    }
    
    func animateShapeSpring(startX: CGFloat, endX: CGFloat) {
        let total = abs(startX - endX)
        let caframeAnimation = CASpringAnimation(keyPath: "position.x")
        caframeAnimation.fromValue = startX
        caframeAnimation.toValue = endX
        caframeAnimation.damping = total/50 + 5
        caframeAnimation.duration = caframeAnimation.settlingDuration
        caframeAnimation.fillMode = .both
        caframeAnimation.isRemovedOnCompletion = false
        selectedLayer.add(caframeAnimation, forKey: "circleLayerAnimationKey")
    }
}
