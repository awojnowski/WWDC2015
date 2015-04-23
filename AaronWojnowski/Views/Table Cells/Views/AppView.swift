//
//  AppView.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-19.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class AppView: UIView {

    private(set) lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clearColor()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        return imageView
        
    }()
    
    private(set) lazy var label: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        label.textColor = UIColor(white: 0.5, alpha: 1.0)
        label.numberOfLines = 0
        self.addSubview(label)
        return label
        
    }()
    
    private(set) lazy var button: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = UIColor.clearColor()
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor().colorWithAlphaComponent(0.5), forState: UIControlState.Highlighted)
        button.setTitle("Learn more by tapping here!", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        self.addSubview(button)
        return button
        
    }()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 200)
        self.imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.imageView.bounds))
        
        let labelWidth: CGFloat = CGRectGetWidth(self.bounds) - 16 * 2
        
        self.label.bounds = CGRectMake(0, 0, labelWidth, 0)
        self.label.sizeToFit()
        
        let imageViewMaxY = CGRectGetHeight(self.imageView.bounds)
        let remainingContentHeight = CGRectGetHeight(self.label.bounds) + 16 + 44
        let remainingHeight = CGRectGetHeight(self.bounds) - imageViewMaxY
        let startingY = imageViewMaxY + (remainingHeight - remainingContentHeight) / 2.0
        
        self.label.bounds = CGRectMake(0, 0, labelWidth, CGRectGetHeight(self.label.bounds))
        self.label.center = CGPointMake(CGRectGetMidX(self.bounds), startingY + CGRectGetMidY(self.label.bounds))
        
        self.button.bounds = CGRectMake(0, 0, labelWidth, 44)
        self.button.center = CGPointMake(CGRectGetMidX(self.bounds), self.label.center.y + CGRectGetHeight(self.label.bounds) / 2.0 + 16 + CGRectGetMidY(self.button.bounds))
        
    }


}
