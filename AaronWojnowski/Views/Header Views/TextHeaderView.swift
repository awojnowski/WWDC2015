//
//  TextHeaderView.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-14.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class TextHeaderView: UIView {
    
    static let height: CGFloat = 100.0

    private(set) lazy var label: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: 36.0)
        label.textColor = UIColor(white: 0.2, alpha: 1.0)
        self.addSubview(label)
        return label
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.label.frame = self.bounds
        
    }

}
