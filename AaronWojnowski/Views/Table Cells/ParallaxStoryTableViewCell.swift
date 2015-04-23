//
//  ParallaxStoryTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-17.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class ParallaxStoryTableViewCell: StoryTableViewCell {
    
    var introOffset: CGFloat = 0 {
        didSet {
            self.didChangeIntroOffset()
        }
    }
    var offset: CGFloat = 0 {
        didSet {
            self.setNeedsLayout()
            self.didChangeOffset()
        }
    }
    var outroOffset: CGFloat = 0 {
        didSet {
            self.didChangeOutroOffset()
        }
    }

    lazy var parallaxView: UIView = {
        
        let parallaxView = self.generateParallaxView()
        self.contentView.addSubview(parallaxView)
        return parallaxView
        
    }()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.parallaxView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.parallaxView.bounds))
        
        let centerBase = CGRectGetMidY(self.parallaxView.bounds) + self.parallaxViewOffset()
        let centerOffset = (CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(self.parallaxView.bounds)) * self.offset
        self.parallaxView.center = CGPointMake(CGRectGetMidX(self.contentView.bounds), centerBase + centerOffset)
        
    }
    
    // MARK: Offsets
    
    func didChangeIntroOffset() {
        
        
        
    }
    
    func didChangeOffset() {
        
        
        
    }
    
    func didChangeOutroOffset() {
        
        
        
    }
    
    // Parallax View (override if necessary)
    
    func parallaxViewOffset() -> CGFloat {
        
        return 0.0
        
    }
    
    func generateParallaxView() -> UIView {
        
        return UIView()
        
    }

}
