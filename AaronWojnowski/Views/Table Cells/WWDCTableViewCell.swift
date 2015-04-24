//
//  WWDCTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-19.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class WWDCTableViewCell: ParallaxStoryTableViewCell, UITableViewDelegate, UITableViewDataSource {

    private(set) static var parallaxViewHeight = {
        
        CGRectGetHeight(UIScreen.mainScreen().bounds) - TextHeaderView.height
        
    }()
    
    private(set) static var cellHeight = {
        
        return WWDCTableViewCell.parallaxViewHeight * 1.5
        
    }()
    
    private lazy var whyLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue-Ultralight", size: 20)
        label.textColor = UIColor(white: 0.2, alpha: 1.0)
        label.text = "Here's why:"
        return label
        
    }()
    
    private var labelTitles: Array<String> = [
        "To get additional exposure to Swift and its accompanying best practices.",
        "To receive valuable insight and feedback in the UI lab.",
        "For the incredible lunchtime speakers and lunchtime lectures.",
        "To learn more about developing for the Apple Watch.",
        "For the cutting edge technical sessions.",
        "For some incredible development inspiration.",
    ]
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(WWDCOptionTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.scrollEnabled = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = nil
        return tableView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.parallaxView.addSubview(self.tableView)
        self.parallaxView.addSubview(self.whyLabel)
        
        if !AppLayoutManager.isAppLarge {
            
            self.whyLabel.hidden = true
            
        }
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.tableView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.parallaxView.bounds), self.tableView.contentSize.height)
        self.tableView.center = CGPointMake(CGRectGetMidX(self.parallaxView.bounds), CGRectGetMidY(self.parallaxView.bounds))
        
        self.whyLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.parallaxView.bounds), 24)
        self.whyLabel.center = CGPointMake(CGRectGetMidX(self.parallaxView.bounds), self.tableView.center.y - CGRectGetMidY(self.tableView.bounds) - CGRectGetMidY(self.whyLabel.bounds) + 10)
        
    }
    
    // MARK: Offsets
    
    override func didChangeIntroOffset() {
        
        
        
    }
    
    override func didChangeOffset() {
        
        
        
    }
    
    override func didChangeOutroOffset() {
        
        
        
    }
    
    // MARK: Parallax
    
    override func parallaxViewOffset() -> CGFloat {
        
        return TextHeaderView.height / 2.0
        
    }
    
    override func generateParallaxView() -> UIView {
        
        let parallaxView = UIView()
        parallaxView.frame = CGRectMake(0, 0, 0, WWDCTableViewCell.parallaxViewHeight)
        return parallaxView
        
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.labelTitles.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let title = self.labelTitles[indexPath.row]
        let cellWidth = CGRectGetWidth(self.tableView.bounds)
        return WWDCOptionTableViewCell.heightForText(title, width: cellWidth)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! WWDCOptionTableViewCell
        cell.titleLabel.text = self.labelTitles[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let viewController = TextViewController()
        
        if (indexPath.row == 0) {
            
            viewController.title = "Swift"
            viewController.fileName = "wwdc_exposure_swift"
            
        } else if (indexPath.row == 1) {
            
            viewController.title = "UI Lab"
            viewController.fileName = "wwdc_ui_lab"
            
        } else if (indexPath.row == 2) {
            
            viewController.title = "Speakers"
            viewController.fileName = "wwdc_lunch_speakers"
            
        } else if (indexPath.row == 3) {
            
            viewController.title = "Apple Watch"
            viewController.fileName = "wwdc_watch"
            
        } else if (indexPath.row == 4) {
            
            viewController.title = "Sessions"
            viewController.fileName = "wwdc_sessions"
            
        } else if (indexPath.row == 5) {
            
            viewController.title = "Inspiration"
            viewController.fileName = "wwdc_preworkout"
            
        }
        
        self.delegate?.storyTableViewCellPushedViewController(self, viewController: viewController)
        
    }

}
