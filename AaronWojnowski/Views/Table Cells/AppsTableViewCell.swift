//
//  AppsTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-19.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import StoreKit
import UIKit

class AppsTableViewCell: ParallaxStoryTableViewCell, SKStoreProductViewControllerDelegate {
    
    private(set) static var parallaxViewHeight = {
        
        CGRectGetHeight(UIScreen.mainScreen().bounds) - TextHeaderView.height
        
    }()
    
    private(set) static var cellHeight = {
        
        return AppsTableViewCell.parallaxViewHeight * 3
        
    }()
    
    private lazy var dockView: UIView = {
        
        let dockView = UIView()
        dockView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return dockView
        
    }()
    
    private lazy var musiAppView: UIView = {
        
        let appView = AppView()
        appView.imageView.image = UIImage(named: "musiBackground")
        appView.button.addTarget(self, action: Selector("learnMusi"), forControlEvents: UIControlEvents.TouchUpInside)
        appView.backgroundColor = UIColor.clearColor()
        if AppLayoutManager.isAppLarge {
            
            appView.label.text = "Musi is my \"official\" side project. Built in late 2013, it allows you to stream music and organize content from YouTube and SoundCloud. Used by hundreds of thousands of people in over 150 countries, Musi has taught me most of what I know about iOS."
            
        } else {
            
            appView.label.text = "Musi is my \"official\" side project. Built in late 2013, it allows you to stream music and organize content from YouTube and SoundCloud."
            
        }
        return appView
        
    }()
    
    private lazy var minusAppView: UIView = {
        
        let appView = AppView()
        appView.imageView.image = UIImage(named: "minusBackground")
        appView.button.addTarget(self, action: Selector("learnMinus"), forControlEvents: UIControlEvents.TouchUpInside)
        appView.backgroundColor = UIColor.clearColor()
        if AppLayoutManager.isAppLarge {
            
            appView.label.text = "I was a part of the Minus (now Meow) iOS team for over 4 years. At Minus, I built high fidelity UI controls and other UI features within the app. Minus taught me about working with a team remotely and iterating through multiple app versions in short periods of time."
            
        } else {
            
            appView.label.text = "I was a part of the Minus (now Meow) iOS team for over 4 years. At Minus, I built high fidelity UI controls and other UI features within the app."
            
        }
        return appView
        
    }()
    
    private lazy var fannexAppView: UIView = {
        
        let appView = AppView()
        appView.imageView.image = UIImage(named: "fannexBackground")
        appView.button.addTarget(self, action: Selector("learnFannex"), forControlEvents: UIControlEvents.TouchUpInside)
        appView.backgroundColor = UIColor.clearColor()
        if AppLayoutManager.isAppLarge {
            
            appView.label.text = "Fannex is a stadium and fan interaction application that I built for Emotion Media Inc. here in Winnipeg. One feature, \"Light Up The Stands\" allows fans to create a video mosaic within the stands of a hockey or other sports game."
            
        } else {
            
            appView.label.text = "Fannex is a stadium and fan interaction application that I built for Emotion Media Inc. here in Winnipeg."
            
        }
        return appView
        
    }()
    
    private lazy var otherAppView: UIView = {
        
        let appView = AppView()
        appView.imageView.image = UIImage(named: "otherBackground")
        appView.button.addTarget(self, action: Selector("learnOther"), forControlEvents: UIControlEvents.TouchUpInside)
        appView.backgroundColor = UIColor.clearColor()
        if AppLayoutManager.isAppLarge {
            
            appView.label.text = "In addition to the previous three, I've built numerous apps for both myself and others throughout my time working with iOS. Some of these include a simple flash-like game to a news reader that serves tens of thousands of people in my home city, Winnipeg."
            
        } else {
            
            appView.label.text = "In addition to the previous three, I've built numerous apps for both myself and others throughout my time working with iOS."
            
        }
        return appView
        
    }()
    
    private lazy var musiButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: Selector("viewMusi"), forControlEvents: UIControlEvents.TouchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.grayColor()
        button.layer.cornerRadius = 16.0
        button.setImage(UIImage(named: "musiIcon"), forState: UIControlState.Normal)
        return button
        
    }()
    
    private lazy var minusButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: Selector("viewMinus"), forControlEvents: UIControlEvents.TouchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.grayColor()
        button.setImage(UIImage(named: "minusIcon"), forState: UIControlState.Normal)
        button.layer.cornerRadius = 16.0
        return button
        
    }()
    
    private lazy var fannexButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: Selector("viewFannex"), forControlEvents: UIControlEvents.TouchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.grayColor()
        button.setImage(UIImage(named: "undIcon"), forState: UIControlState.Normal)
        button.layer.cornerRadius = 16.0
        return button
        
    }()
    
    private lazy var otherButton: UIButton = {
        
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = UIColor.grayColor()
        button.setImage(UIImage(named: "otherIcon"), forState: UIControlState.Normal)
        button.layer.cornerRadius = 16.0
        button.userInteractionEnabled = false
        return button
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.parallaxView.addSubview(self.musiAppView)
        self.parallaxView.addSubview(self.minusAppView)
        self.parallaxView.addSubview(self.fannexAppView)
        self.parallaxView.addSubview(self.otherAppView)
        
        self.parallaxView.addSubview(self.dockView)
        self.dockView.addSubview(self.musiButton)
        self.dockView.addSubview(self.minusButton)
        self.dockView.addSubview(self.fannexButton)
        self.dockView.addSubview(self.otherButton)
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.dockView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.parallaxView.bounds), 96)
        self.dockView.center = CGPointMake(CGRectGetMidX(self.parallaxView.bounds), CGRectGetHeight(self.parallaxView.bounds) - CGRectGetMidY(self.dockView.bounds))
        
        self.musiAppView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.parallaxView.bounds), CGRectGetHeight(self.parallaxView.bounds) - CGRectGetHeight(self.dockView.bounds))
        self.minusAppView.bounds = self.musiAppView.bounds
        self.fannexAppView.bounds = self.musiAppView.bounds
        self.otherAppView.bounds = self.musiAppView.bounds
        
        self.musiAppView.center = CGPointMake(CGRectGetMidX(self.parallaxView.bounds), CGRectGetMidY(self.parallaxView.bounds) - CGRectGetHeight(self.dockView.bounds) / 2.0)
        self.minusAppView.center = self.musiAppView.center
        self.fannexAppView.center = self.musiAppView.center
        self.otherAppView.center = self.musiAppView.center
        
        self.musiButton.bounds = CGRectMake(0, 0, 60, 60)
        self.minusButton.bounds = CGRectMake(0, 0, 60, 60)
        self.fannexButton.bounds = CGRectMake(0, 0, 60, 60)
        self.otherButton.bounds = CGRectMake(0, 0, 60, 60)
        
        let padding = (CGRectGetWidth(self.dockView.bounds) - 4 * CGRectGetWidth(self.musiButton.bounds)) / 5.0
        self.musiButton.center = CGPointMake(padding * 1 + CGRectGetMidX(self.musiButton.bounds), CGRectGetMidY(self.dockView.bounds))
        self.minusButton.center = CGPointMake(padding * 2 + CGRectGetWidth(self.musiButton.bounds) * 1 + CGRectGetMidX(self.musiButton.bounds), CGRectGetMidY(self.dockView.bounds))
        self.fannexButton.center = CGPointMake(padding * 3 + CGRectGetWidth(self.musiButton.bounds) * 2 + CGRectGetMidX(self.musiButton.bounds), CGRectGetMidY(self.dockView.bounds))
        self.otherButton.center = CGPointMake(padding * 4 + CGRectGetWidth(self.musiButton.bounds) * 3 + CGRectGetMidX(self.musiButton.bounds), CGRectGetMidY(self.dockView.bounds))
        
    }
    
    // MARK: Actions
    
    func viewMusi() {
        
        self.viewAppIdentifier(591560124, sender: self.musiButton)
        
    }
    
    func learnMusi() {
        
        self.learnMoreAboutApp("Musi", fileName: "musi")
        
    }
    
    func viewMinus() {
        
        self.viewAppIdentifier(585660589, sender: self.minusButton)
        
    }
    
    func learnMinus() {
        
        self.learnMoreAboutApp("Minus", fileName: "minus")
        
    }
    
    func viewFannex() {
        
        self.viewAppIdentifier(824982957, sender: self.fannexButton)
        
    }
    
    func learnFannex() {
        
        self.learnMoreAboutApp("Fannex", fileName: "fannex")
        
    }
    
    func learnOther() {
        
        self.learnMoreAboutApp("Other", fileName: "other")
        
    }
    
    // MARK: Apps
    
    func viewAppIdentifier(identifier: Int, sender: UIButton?) {
        
        var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicatorView.bounds = CGRectMake(0, 0, 20, 20)
        activityIndicatorView.center = sender?.center ?? CGPointZero
        activityIndicatorView.startAnimating()
        
        if sender != nil {
            
            sender!.superview?.addSubview(activityIndicatorView)
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                sender!.alpha = 0.5
                
            });
            
        }
        
        self.dockView.userInteractionEnabled = false
        
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        storeViewController.loadProductWithParameters([ SKStoreProductParameterITunesItemIdentifier : NSNumber(integer: identifier)], completionBlock: { (result, error) -> Void in
            
            self.dockView.userInteractionEnabled = true
            activityIndicatorView.removeFromSuperview()
            
            if sender != nil {
                
                sender!.alpha = 1.0
                
            }
            
            if result {
                
                self.delegate?.storyTableViewCellPresentedViewController(self, viewController: storeViewController)
                
            }
            
        })
        
    }
    
    func learnMoreAboutApp(title: String, fileName: String) {
        
        let viewController = TextViewController()
        viewController.title = title
        viewController.fileName = fileName
        self.delegate?.storyTableViewCellPushedViewController(self, viewController: viewController)
        
    }
    
    // MARK: Offsets
    
    override func didChangeIntroOffset() {
        
        
        
    }
    
    override func didChangeOffset() {
        
        let offset = self.offset
        
        // decide which page to show
        
        let appViews = [self.musiAppView, self.minusAppView, self.fannexAppView, self.otherAppView]
        let appButtons = [self.musiButton, self.minusButton, self.fannexButton, self.otherButton]
        let appOffset: CGFloat = 1.0 / CGFloat(appViews.count)
        let appBuffer: CGFloat = 0.1
        let appBufferHalf: CGFloat = appBuffer / 2.0
        
        for (index, appView) in enumerate(appViews) {
            
            let minOffset: CGFloat = CGFloat(index) * appOffset
            let maxOffset: CGFloat = CGFloat(index + 1) * appOffset
            var appViewOffset: CGFloat = 0.0
            
            if offset < minOffset - appBufferHalf {
                
                appViewOffset = 0.0
                
            } else if offset < minOffset + appBufferHalf {
                
                if index == 0 {
                    
                    appViewOffset = 1.0
                    
                } else {
                    
                    appViewOffset = (offset - minOffset + appBufferHalf) / appBuffer
                    
                }
                
            } else if offset < maxOffset - appBufferHalf {
                
                appViewOffset = 1.0
                
            } else if offset < maxOffset + appBufferHalf {
                
                if index == appViews.count - 1 {
                    
                    appViewOffset = 1.0
                    
                } else {
                    
                    appViewOffset = abs(offset - maxOffset - appBufferHalf) / appBuffer
                    
                }
                
            } else {
                
                appViewOffset = 0.0
                
            }
            
            appView.alpha = appViewOffset
            appView.userInteractionEnabled = (appView.alpha > 0.5)
            
            let scale = 0.8 + (appViewOffset * 0.2)
            appButtons[index].transform = CGAffineTransformMakeScale(scale, scale)
            
        }
        
        // animate the dock in or out
        
        let introDockDelta: CGFloat = 0.025
        let outroDockDelay: CGFloat = 0.05
        let outroDockDelta: CGFloat = 0.05
        let dockTransform = CGRectGetHeight(self.dockView.bounds)
        
        if offset < introDockDelta {
            
            self.dockView.transform = CGAffineTransformMakeTranslation(0, dockTransform * (1.0 - offset / introDockDelta))
            
        } else {
            
            if offset > 1.0 - outroDockDelta - outroDockDelay {
                
                if (offset > 1.0 - outroDockDelay) {
                    
                    self.dockView.transform = CGAffineTransformMakeTranslation(0, dockTransform)
                    
                } else {
                    
                    let transform = dockTransform * ((offset - 1.0 + outroDockDelta + outroDockDelay) / outroDockDelta)
                    self.dockView.transform = CGAffineTransformMakeTranslation(0, transform)
                    
                }
                
            } else {
                
                self.dockView.transform = CGAffineTransformIdentity
                
            }
            
        }
        
    }
    
    override func didChangeOutroOffset() {
        
        
        
    }
    
    // MARK: Parallax
    
    override func parallaxViewOffset() -> CGFloat {
        
        return TextHeaderView.height / 2.0
        
    }
    
    override func generateParallaxView() -> UIView {
        
        let parallaxView = UIView()
        parallaxView.frame = CGRectMake(0, 0, 0, AppsTableViewCell.parallaxViewHeight)
        parallaxView.clipsToBounds = true
        return parallaxView
        
    }
    
    // MARK: SKStoreProductViewControllerDelegate
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
    
        viewController.dismissViewControllerAnimated(true, completion: nil)
    
    }

}
