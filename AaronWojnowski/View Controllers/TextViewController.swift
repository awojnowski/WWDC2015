//
//  TextViewController.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-20.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var fileName: String?
    
    private lazy var headerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        return view
        
    }()
    
    private lazy var backButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: Selector("back"), forControlEvents: UIControlEvents.TouchUpInside)
        button.setImage(UIImage(named: "backArrowImage"), forState: UIControlState.Normal)
        return button
        
    }()
    
    private lazy var lineView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        return view
        
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: 28)
        label.textColor = UIColor(white: 0.2, alpha: 1.0)
        return label
        
    }()
    
    private lazy var textView: UITextView = {
        
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        textView.textColor = UIColor(white: 0.5, alpha: 1.0)
        textView.clipsToBounds = false
        
        if let fileName = self.fileName {
            
            let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: "wwdccopy")
            let text = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: nil)
            textView.text = text as! String
            
        }
        
        return textView
        
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.textView)
        self.view.addSubview(self.headerView)
        self.headerView.addSubview(self.backButton)
        self.headerView.addSubview(self.lineView)
        self.headerView.addSubview(self.titleLabel)
        
        self.titleLabel.text = self.title
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let lineHeight = 1.0 / UIScreen.mainScreen().scale
        
        self.headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 20 + 64 + lineHeight)
        self.backButton.frame = CGRectMake(0, 20, 64, 64)
        self.titleLabel.frame = CGRectMake(0, 20, CGRectGetWidth(self.headerView.bounds), 64)
        self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.headerView.bounds) - lineHeight, CGRectGetWidth(self.headerView.bounds), lineHeight)

        self.textView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.headerView.bounds) + 4, 0, 0, 0)
        self.textView.textContainerInset = UIEdgeInsetsMake(14, 16, 14, 16)
        self.textView.scrollIndicatorInsets = UIEdgeInsetsMake(self.textView.contentInset.top, 0, 0, 0)
        self.textView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))
        
    }
    
    // MARK: Actions
    
    func back() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
