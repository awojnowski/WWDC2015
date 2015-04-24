//
//  AboutMeTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-17.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class AboutMeTableViewCell: ParallaxStoryTableViewCell {
    
    private(set) static var parallaxViewHeight = {
        
        CGRectGetHeight(UIScreen.mainScreen().bounds) - TextHeaderView.height
        
    }()
    
    private(set) static var cellHeight = {
        
        return AboutMeTableViewCell.parallaxViewHeight * 2
        
    }()
    
    private lazy var ageView: TextIconView = {
        
        let view = TextIconView()
        view.label.text = "I'm 19 years old"
        view.subtitleLabel.text = "But some say I barely look my shoe size"
        view.imageView.image = UIImage(named: "cakeIcon")
        self.parallaxView.addSubview(view)
        return view
        
    }()
    
    private lazy var locationView: TextIconView = {
        
        let view = TextIconView()
        view.label.text = "From Winnipeg, Canada"
        view.subtitleLabel.text = "Where it snows in April"
        view.imageView.image = UIImage(named: "globeIcon")
        self.parallaxView.addSubview(view)
        return view
        
    }()
    
    private lazy var educationView: TextIconView = {
        
        let view = TextIconView()
        view.label.text = "I'm a second year university student"
        view.subtitleLabel.text = "In fact, you can call me Stu Dent"
        view.imageView.image = UIImage(named: "graduationIcon")
        self.parallaxView.addSubview(view)
        return view
        
    }()
    
    private lazy var appView: TextIconView = {
        
        let attributedText = NSMutableAttributedString(string: "And I love building apps.")
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(6, 4))
        
        let view = TextIconView()
        view.label.attributedText = attributedText
        view.subtitleLabel.text = "I can't verify it, but I'm pretty sure I was innovating in the womb"
        view.imageView.image = UIImage(named: "hammerIcon")
        self.parallaxView.addSubview(view)
        return view
        
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        var contentInset: CGFloat = 16
        if (CGRectGetHeight(UIScreen.mainScreen().bounds) > 568) {
            
            contentInset = 48
            
        }
        
        let contentRect = CGRectInset(self.parallaxView.bounds, contentInset, 0)
        
        // avoid expensive and unnecessary layout calls
        if CGRectGetWidth(self.ageView.frame) != CGRectGetWidth(contentRect) {
        
            let ageViewHeight: CGFloat = TextIconView.heightForText(self.ageView.label.text!, subtitle: self.ageView.subtitleLabel.text!, width: CGRectGetWidth(contentRect))
            let locationViewHeight: CGFloat = TextIconView.heightForText(self.locationView.label.text!, subtitle: self.locationView.subtitleLabel.text!, width: CGRectGetWidth(contentRect))
            let educationViewHeight: CGFloat = TextIconView.heightForText(self.educationView.label.text!, subtitle: self.educationView.subtitleLabel.text!, width: CGRectGetWidth(contentRect))
            let appViewHeight: CGFloat = TextIconView.heightForText(self.appView.label.attributedText!.string, subtitle: self.appView.subtitleLabel.text!, width: CGRectGetWidth(contentRect))
            
            let height = ageViewHeight + locationViewHeight + educationViewHeight + appViewHeight;
            
            self.ageView.frame = CGRectMake(CGRectGetMinX(contentRect), CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - height) / 2.0, CGRectGetWidth(contentRect), ageViewHeight)
            self.locationView.frame = CGRectMake(CGRectGetMinX(contentRect), CGRectGetMaxY(self.ageView.frame), CGRectGetWidth(contentRect), locationViewHeight)
            self.educationView.frame = CGRectMake(CGRectGetMinX(contentRect), CGRectGetMaxY(self.locationView.frame), CGRectGetWidth(contentRect), educationViewHeight)
            self.appView.frame = CGRectMake(CGRectGetMinX(contentRect), CGRectGetMaxY(self.educationView.frame), CGRectGetWidth(contentRect), appViewHeight)
        
        }
        
    }
    
    // MARK: Offsets
    
    override func didChangeIntroOffset() {
        
        if self.introOffset > 0.5 {
            
            let ageViewOffset: CGFloat =  (self.introOffset - 0.5) / 0.5
            let transformDelta: CGFloat = 10.0
            
            self.ageView.alpha = ageViewOffset
            self.ageView.label.transform = CGAffineTransformMakeTranslation(transformDelta - transformDelta * ageViewOffset, 0)
            self.ageView.subtitleLabel.transform = self.ageView.label.transform
            
        } else {
            
            self.ageView.alpha = 0.0
            
        }
        
    }
    
    override func didChangeOffset() {
        
        let offset = self.offset
        if offset == 0.0 {
            
            self.locationView.alpha = 0.0
            self.educationView.alpha = 0.0
            self.appView.alpha = 0.0
            
        } else {
            
            func offsetForViewAtIndex(index: Int) -> CGFloat {
                
                let minimumOffset: CGFloat = CGFloat(index) * 0.25
                if offset < minimumOffset {
                    
                    return 0.0
                    
                }
                return min((offset - minimumOffset) / 0.2, 1.0)
                
            }
            
            let locationViewOffset = offsetForViewAtIndex(0)
            let educationViewOffset = offsetForViewAtIndex(1)
            let appViewOffset = offsetForViewAtIndex(2)
            
            self.locationView.alpha = locationViewOffset
            self.educationView.alpha = educationViewOffset
            self.appView.alpha = appViewOffset
            
            let transformDelta: CGFloat = 10.0
            self.locationView.label.transform = CGAffineTransformMakeTranslation(transformDelta - transformDelta * locationViewOffset, 0)
            self.educationView.label.transform = CGAffineTransformMakeTranslation(transformDelta - transformDelta * educationViewOffset, 0)
            self.appView.label.transform = CGAffineTransformMakeTranslation(transformDelta - transformDelta * appViewOffset, 0)
            
            self.locationView.subtitleLabel.transform = self.locationView.label.transform
            self.educationView.subtitleLabel.transform = self.educationView.label.transform
            self.appView.subtitleLabel.transform = self.appView.label.transform
            
        }
        
    }
    
    override func didChangeOutroOffset() {
        
        if (self.outroOffset > 0.0) {
                        
            let offset = 1.0 - min(self.outroOffset / 0.45, 1.0)
            
            self.ageView.alpha = offset
            self.locationView.alpha = offset
            self.educationView.alpha = offset
            self.appView.alpha = offset
            
        }
        
    }
    
    // MARK: Parallax
    
    override func parallaxViewOffset() -> CGFloat {
        
        return TextHeaderView.height / 2.0 - 10.0 /* header padding delta */
        
    }
    
    override func generateParallaxView() -> UIView {
        
        let parallaxView = UIView()
        parallaxView.frame = CGRectMake(0, 0, 0, AboutMeTableViewCell.parallaxViewHeight)
        return parallaxView
        
    }
    
}
