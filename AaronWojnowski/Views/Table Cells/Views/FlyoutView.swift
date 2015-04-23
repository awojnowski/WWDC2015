//
//  FlyoutView.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-21.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class FlyoutView: UIView {

    static var sizeRatio: CGSize = {
        
        return UIImage(named: "footerCouch")!.size
        
    }()
    
    private(set) lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "footerCouch")
        self.addSubview(imageView)
        return imageView
        
    }()
    
    private(set) lazy var personImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flyBody")
        self.addSubview(imageView)
        return imageView
        
    }()
    
    private(set) lazy var personLeftArmImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftArm")
        imageView.layer.anchorPoint = CGPointMake(0.8793, 0.886)
        self.personImageView.addSubview(imageView)
        return imageView
    
    }()
    
    private(set) lazy var personRightArmImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArm")
        imageView.layer.anchorPoint = CGPointMake(0.1277, 0.89)
        self.personImageView.addSubview(imageView)
        return imageView
        
    }()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.imageView.frame = self.bounds
        
        let personImageViewScale = 0.819 / (self.personImageView.image!.size.height / CGRectGetHeight(self.imageView.bounds))
        self.personImageView.bounds = CGRectMake(0, 0, self.personImageView.image!.size.width * personImageViewScale, self.personImageView.image!.size.height * personImageViewScale)
        self.personImageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        
        self.personLeftArmImageView.bounds = CGRectMake(0, 0, self.personLeftArmImageView.image!.size.width * personImageViewScale, self.personLeftArmImageView.image!.size.height * personImageViewScale)
        self.personLeftArmImageView.center = CGPointMake(0.20 * CGRectGetWidth(self.personImageView.bounds), 0.39 * CGRectGetHeight(self.personImageView.bounds))
        
        self.personRightArmImageView.bounds = CGRectMake(0, 0, self.personRightArmImageView.image!.size.width * personImageViewScale, self.personRightArmImageView.image!.size.height * personImageViewScale)
        self.personRightArmImageView.center = CGPointMake(0.83 * CGRectGetWidth(self.personImageView.bounds), 0.37 * CGRectGetHeight(self.personImageView.bounds))
        
    }
    
    // MARK: Rotation
    
    func setRotationOffset(offset: CGFloat) {
        
        let offsetAmount = fmod(offset, 2)
        
        var normalizedOffset: CGFloat = 0.0
        if offsetAmount < 1.0 {
            
            normalizedOffset = offsetAmount
            
        } else if offsetAmount < 2.0 {
            
            normalizedOffset = 1.0 - ((offsetAmount - 1.0) * 1.0)
            
        }
        
        let spread: CGFloat = 0.05
        let angle = -0.02 + normalizedOffset * spread * 2
        
        let transform = CGAffineTransformMakeRotation(2 * CGFloat(M_PI) * angle)
        self.personLeftArmImageView.transform = transform
        self.personRightArmImageView.transform = transform
        
    }
    
    private var isFlying = false
    func fly() -> UIView? {
        
        if self.isFlying {
            
            return nil
            
        }
        self.isFlying = true
        
        self.rotateView(self.personLeftArmImageView)
        self.rotateView(self.personRightArmImageView)
        
        return self.personImageView
        
    }
    
    func stopFlying() {
        
        if !self.isFlying {
            
            return
            
        }
        self.isFlying = false
        
        self.stopRotatingView(self.personLeftArmImageView)
        self.stopRotatingView(self.personRightArmImageView)
        
    }
    
    func rotateView(view: UIView) {
        
        if view.layer.animationForKey("rotate") == nil {
            
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(M_PI * 2.0)
            rotationAnimation.duration = 0.5
            rotationAnimation.repeatCount = Float.infinity
            
            view.layer.addAnimation(rotationAnimation, forKey: "rotate")
            
        }
        
    }
    
    
    func stopRotatingView(view: UIView) {
        
        if view.layer.animationForKey("rotate") != nil {
            
            view.layer.removeAnimationForKey("rotate")
            
        }
        
    }

    // MARK: Class Methods
    
    static func heightForWidth(width: CGFloat) -> CGFloat {
        
        let ratio = FlyoutView.sizeRatio.height / FlyoutView.sizeRatio.width
        return ratio * width
        
    }
    
}
