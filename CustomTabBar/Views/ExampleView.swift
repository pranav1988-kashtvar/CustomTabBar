//
//  ExampleView.swift
//  BicycleApp
//
//  Created by Shi Pra on 30/09/22.
//

import UIKit

struct ViewModal {
    var label: String
}

class ExampleView: UIView {

    var viewModel: ViewModal? {
        didSet {
            configure()
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        label.anchor(top: self.topAnchor, left: self.leadingAnchor, bottom: self.bottomAnchor, right: self.trailingAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20)
    }
    
    func setup() {
        self.addSubview(label)
    }
    
    func configure() {
        guard let model = viewModel else {
            return
        }
        label.text = model.label
    }
}
