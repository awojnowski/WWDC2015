//
//  TextIconView.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-18.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class TextIconView: UIView {
    
    static var mainLabelSize: CGFloat = {
        
        if AppLayoutManager.isAppLarge {
            
            return 28.0
            
        } else {
            
            return 22.0
            
        }
        
    }()
    
    static let heightPadding: CGFloat = 16
    static let labelPadding: CGFloat = 16
    static let imageSize: CGFloat = 48
    
    private(set) lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clearColor()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(imageView)
        return imageView
    
    }()
    
    private(set) lazy var label: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: TextIconView.mainLabelSize)
        label.textColor = UIColor(white: 0.2, alpha: 1.0)
        label.numberOfLines = 0
        self.addSubview(label)
        return label
        
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.textColor = UIColor(white: 0.5, alpha: 1.0)
        label.numberOfLines = 0
        self.addSubview(label)
        return label
        
    }()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.imageView.bounds = CGRectMake(0, 0, TextIconView.imageSize, TextIconView.imageSize)
        self.imageView.center = CGPointMake(TextIconView.imageSize / 2.0, CGRectGetMidY(self.bounds))
        
        let labelWidth = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.imageView.bounds) - TextIconView.labelPadding;
        
        self.label.bounds = CGRectMake(0, 0, labelWidth, 0)
        self.label.sizeToFit()
        self.label.bounds = CGRectMake(0, 0, labelWidth, CGRectGetHeight(self.label.bounds))
        self.label.center = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(self.label.bounds) / 2.0, TextIconView.heightPadding + CGRectGetMidY(self.label.bounds))
        
        self.subtitleLabel.bounds = CGRectMake(0, 0, labelWidth, 0)
        self.subtitleLabel.sizeToFit()
        self.subtitleLabel.bounds = CGRectMake(0, 0, labelWidth, CGRectGetHeight(self.subtitleLabel.bounds))
        self.subtitleLabel.center = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(self.subtitleLabel.bounds) / 2.0, TextIconView.heightPadding + CGRectGetMaxY(self.label.bounds) + TextIconView.heightPadding / 2.0 + CGRectGetMidY(self.subtitleLabel.bounds))
        
    }
    
    // MARK: Class Methods
    
    static func heightForText(text: String, subtitle: String, width: CGFloat) -> CGFloat {
        
        let labelWidth = width - TextIconView.labelPadding - TextIconView.imageSize
        
        var height = TextIconView.heightPadding
        
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: TextIconView.mainLabelSize)
        label.numberOfLines = 0

        label.frame = CGRectMake(0, 0, labelWidth, 0)
        label.text = text
        label.sizeToFit()
        
        height += CGRectGetHeight(label.bounds)
        height += TextIconView.heightPadding / 2.0
        
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        
        label.frame = CGRectMake(0, 0, labelWidth, 0)
        label.text = subtitle
        label.sizeToFit()
        
        height += CGRectGetHeight(label.bounds)
        height += TextIconView.heightPadding
        
        return height
        
    }

}
