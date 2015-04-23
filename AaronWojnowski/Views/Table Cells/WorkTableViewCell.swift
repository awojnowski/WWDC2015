//
//  WorkTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-19.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class WorkTableViewCell: ParallaxStoryTableViewCell {

    private(set) static var parallaxViewHeight = {
        
        CGRectGetHeight(UIScreen.mainScreen().bounds)
        
    }()
    
    private(set) static var cellHeight = {
        
        return WorkTableViewCell.parallaxViewHeight * 2.0
        
    }()
    
    private lazy var schoolBackgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "schoolBackground")
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView

    }()
    
    private lazy var workBackgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "workBackground")
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    private lazy var schoolBackgroundView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.35)
        return view
        
    }()
    
    private lazy var schoolSubtitleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: 28)
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.numberOfLines = 0
        label.shadowColor = UIColor(white: 0.0, alpha: 0.4)
        label.shadowOffset = CGSizeZero
        label.text = "At the University of Manitoba, I'm finishing up my second year studying Computer Science"
        return label
        
    }()
    
    private lazy var workBackgroundView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.35)
        return view
        
    }()
    
    private lazy var workSubtitleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: 28)
        label.textColor = UIColor(white: 1.0, alpha: 1.0)
        label.numberOfLines = 0
        label.shadowColor = UIColor(white: 0.0, alpha: 0.4)
        label.shadowOffset = CGSizeZero
        label.text = "On top of school, for 5 years I've worked with iOS commercially for clients all over the globe"
        return label
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.parallaxView.addSubview(self.schoolBackgroundImageView)
        self.parallaxView.addSubview(self.workBackgroundImageView)
        self.parallaxView.addSubview(self.schoolBackgroundView)
        self.schoolBackgroundView.addSubview(self.schoolSubtitleLabel)
        self.parallaxView.addSubview(self.workBackgroundView)
        self.workBackgroundView.addSubview(self.workSubtitleLabel)
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.schoolBackgroundImageView.frame = self.parallaxView.bounds
        self.workBackgroundImageView.frame = self.parallaxView.bounds
        
        // skewl
        
        self.schoolSubtitleLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.parallaxView.bounds) - 16 * 2, 0)
        self.schoolSubtitleLabel.sizeToFit()
        
        self.schoolBackgroundView.bounds = CGRectInset(self.schoolSubtitleLabel.bounds, -100, -16)
        self.schoolBackgroundView.center = CGPointMake(CGRectGetMidX(self.parallaxView.bounds), CGRectGetHeight(self.parallaxView.bounds) - CGRectGetMidY(self.schoolSubtitleLabel.bounds) - 100)
        
        self.schoolSubtitleLabel.center = CGPointMake(CGRectGetMidX(self.schoolBackgroundView.bounds), CGRectGetMidY(self.schoolBackgroundView.bounds))
        
        // work
        
        self.workSubtitleLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.parallaxView.bounds) - 16 * 2, 0)
        self.workSubtitleLabel.sizeToFit()
        
        self.workBackgroundView.bounds = CGRectInset(self.workSubtitleLabel.bounds, -100, -16)
        self.workBackgroundView.center = CGPointMake(CGRectGetMidX(self.parallaxView.bounds), CGRectGetHeight(self.parallaxView.bounds) - CGRectGetMidY(self.workSubtitleLabel.bounds) - 100)
        
        self.workSubtitleLabel.center = CGPointMake(CGRectGetMidX(self.workBackgroundView.bounds), CGRectGetMidY(self.workBackgroundView.bounds))
        
    }
    
    // MARK: Offsets
    
    override func didChangeIntroOffset() {
        
        
        
    }
    
    override func didChangeOffset() {
        
        let offset = self.offset
        
        // let's do a little bit of parallax
        
        self.schoolBackgroundView.transform = CGAffineTransformMakeTranslation(0, -20 * (offset / 0.5))
        self.workBackgroundView.transform = CGAffineTransformMakeTranslation(0, -20 * ((offset - 0.5) / 0.5))
        
        // calculate the alpha channels
        
        let swapDelta: CGFloat = 0.2
        let swapHalf = (1.0 - swapDelta) / 2.0
        
        var workAlpha: CGFloat = 0.0
        
        if offset < swapHalf {
            
            workAlpha = 0.0
            
        } else if offset < swapHalf + swapDelta {
            
            workAlpha = (offset - swapHalf) / swapDelta
            
        } else {
            
            workAlpha = 1.0
            
        }
        
        self.schoolBackgroundView.alpha = 1.0 - workAlpha
        self.workBackgroundImageView.alpha = workAlpha
        self.workBackgroundView.alpha = workAlpha
                
    }
    
    override func didChangeOutroOffset() {
        
        
        
    }
    
    // MARK: Parallax
    
    override func parallaxViewOffset() -> CGFloat {
        
        return 0.0
        
    }
    
    override func generateParallaxView() -> UIView {
        
        let parallaxView = UIView()
        parallaxView.frame = CGRectMake(0, 0, 0, WorkTableViewCell.parallaxViewHeight)
        return parallaxView
        
    }

}
