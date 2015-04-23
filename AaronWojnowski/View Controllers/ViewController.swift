//
//  ViewController.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-14.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import CoreImage
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryTableViewCellDelegate {
    
    private lazy var instructionsLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.text = "scroll down to begin"
        label.textColor = UIColor(white: 0.65, alpha: 1.0)
        label.numberOfLines = 0
        return label
        
    }()
    
    private lazy var headerImageView: UIImageView = {
        
        let headerImageView = UIImageView()
        headerImageView.image = UIImage(named: "headerImage")
        headerImageView.contentMode = UIViewContentMode.ScaleAspectFill
        headerImageView.clipsToBounds = true
        return headerImageView
        
    }()
    
    private lazy var headerImageViewDimmingView: UIView = {
        
        let dimmingView = UIView()
        dimmingView.backgroundColor = UIColor.blackColor()
        dimmingView.alpha = 0.0
        return dimmingView
        
    }()
    
    private lazy var headerImageViewBlurView : UIImageView = {
        
        let headerImageViewBlurView = UIImageView()
        headerImageViewBlurView.contentMode = UIViewContentMode.ScaleAspectFill
        headerImageViewBlurView.clipsToBounds = true
        return headerImageViewBlurView
        
    }()
    
    private lazy var footerFlyoutView: FlyoutView = {
        
        let flyoutView = FlyoutView()
        flyoutView.clipsToBounds = false
        return flyoutView
    
    }()
    
    private lazy var thanksLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        label.textColor = UIColor(white: 0.5, alpha: 1.0)
        label.text = "Thank you for considering me\nfor a WWDC 2015 student scholarship.\n\nI hope to see you there!\n\n(make sure to scroll down far too 😄)"
        label.numberOfLines = 0
        label.alpha = 0.0
        return label
        
    }()
    
    private lazy var dataSource: StoryDataSource = self.generateDataSource()
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.showsVerticalScrollIndicator = false
        return tableView
        
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.footerFlyoutView)
        self.view.addSubview(self.headerImageView)
        self.headerImageView.addSubview(self.headerImageViewDimmingView)
        self.headerImageView.addSubview(self.headerImageViewBlurView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.instructionsLabel)
        self.view.addSubview(self.thanksLabel)
        
        // now we can generate the blurred image
        
        self.generateBlurredImage(self.headerImageView.image!, completionHandler: { (var image) -> () in
            
            self.headerImageViewBlurView.image = image
            
        })
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.tableView.frame = self.view.bounds
        self.refreshHeaderImageView()
        
        let flyoutViewHeight = FlyoutView.heightForWidth(CGRectGetWidth(UIScreen.mainScreen().bounds))
        self.footerFlyoutView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - flyoutViewHeight, CGRectGetWidth(self.view.bounds), flyoutViewHeight)
        
        self.instructionsLabel.bounds = CGRectZero
        self.instructionsLabel.sizeToFit()
        self.instructionsLabel.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMidY(self.instructionsLabel.bounds) - 16)
        
        self.thanksLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 16 * 2, CGRectGetHeight(self.view.bounds) / 2.0 - TextHeaderView.height)
        self.thanksLabel.center = CGPointMake(CGRectGetMidX(self.view.bounds), (CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.footerFlyoutView.bounds)) / 2.0 + (TextHeaderView.height - 20) / 2.0)
        
    }
    
    // MARK: Header Image View
    
    func refreshHeaderImageView() {
        
        let originalHeight = CGRectGetHeight(self.tableView.bounds) / 2.0
        
        let offset = self.tableView.contentOffset.y
        let height = max(0, originalHeight - offset)
        self.headerImageView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), height)
        self.headerImageView.center = CGPointMake(CGRectGetWidth(self.headerImageView.bounds) / 2.0, height / 2.0)
        
        let ratio = height / originalHeight
        self.headerImageViewDimmingView.alpha = 0.5 - ratio * 0.5
        self.headerImageViewDimmingView.frame = self.headerImageView.bounds
        self.headerImageViewBlurView.alpha = (ratio - 1.0) * 3.0
        self.headerImageViewBlurView.frame = CGRectInset(self.headerImageView.bounds, -5, -5)
        
    }
    
    // MARK: StoryTableViewCellDelegate
    
    func storyTableViewCellPushedViewController(storyTableViewCell: StoryTableViewCell, viewController: UIViewController) {
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func storyTableViewCellPresentedViewController(storyTableViewCell: StoryTableViewCell, viewController: UIViewController) {
        
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    // MARK: UITableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.dataSource.totalSections()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.sectionAtIndex(section).totalRows()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let section = self.dataSource.sectionAtIndex(indexPath.section)
        return section.heightForRowAtIndex(indexPath.row, height: CGRectGetHeight(tableView.bounds))
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let section = self.dataSource.sectionAtIndex(section)
        return CGRectGetHeight(section.headerView?.bounds ?? CGRectZero)
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section = self.dataSource.sectionAtIndex(section)
        return section.headerView
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = self.dataSource.sectionAtIndex(indexPath.section)
        let cellClass: AnyClass = section.cellClassAtIndex(indexPath.row)
        
        let identifier = NSStringFromClass(cellClass)
        
        var cell: StoryTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? StoryTableViewCell
        if (cell == nil) {
            
            cell = PolymorphicTableViewCellFactory.tableViewCellFromClass(cellClass, reuseIdentifier: identifier) as? StoryTableViewCell
            
        }
        
        cell!.delegate = self
        section.setupCell(indexPath.row, cell: cell!)
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.view.setNeedsLayout()
        
        // edit the instruction label
        
        let contentOffset = scrollView.contentOffset.y
        if contentOffset > 0 {
            
            let offset = min(contentOffset / 80.0, 1.0)
            self.instructionsLabel.alpha = 1.0 - offset
            self.instructionsLabel.transform = CGAffineTransformMakeTranslation(0, -30.0 * offset)
            
        } else if contentOffset < 20 {
            
            let offset = min(abs(contentOffset) / 40.0, 1.0)
            self.instructionsLabel.alpha = 1.0 - offset
            self.instructionsLabel.transform = CGAffineTransformMakeTranslation(0, 10.0 * offset)
            
        } else {
            
            self.instructionsLabel.alpha = 1.0
            self.instructionsLabel.transform = CGAffineTransformIdentity
            
        }
        
        // edit the thank you label
        
        let thanksDelta: CGFloat = 50
        let thanksOffset: CGFloat = scrollView.contentSize.height - CGRectGetHeight(scrollView.bounds) - thanksDelta
        if contentOffset > thanksOffset {
            
            let offset = min((contentOffset - thanksOffset) / thanksDelta, 1.0)
            self.thanksLabel.alpha = offset
            
        } else {
            
            self.thanksLabel.alpha = 0.0
            
        }
        
        // rotate the footer
        
        let rotationOffset = contentOffset / 50.0
        self.footerFlyoutView.setRotationOffset(rotationOffset)
        
        // calculate footer flying
        
        if contentOffset > scrollView.contentSize.height - CGRectGetHeight(scrollView.bounds) + 100 {
            
            scrollView.userInteractionEnabled = false
            let flyViewOptional: UIView? = self.footerFlyoutView.fly()
            if let flyView = flyViewOptional {
                
                self.view.bringSubviewToFront(self.footerFlyoutView)
                UIView.animateWithDuration(NSTimeInterval(1.5), delay: NSTimeInterval(0.0), options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    
                    let rotationDelta: CGFloat = 0.12
                    let rotationAngle: CGFloat = -rotationDelta + CGFloat(arc4random_uniform(100)) / 100.0 * CGFloat(2.0 * rotationDelta)
                    
                    var transform = CGAffineTransformIdentity
                    transform = CGAffineTransformRotate(transform, CGFloat(M_PI) * rotationAngle)
                    transform = CGAffineTransformTranslate(transform, -50 + CGFloat(arc4random_uniform(100)), -800)
                    flyView.transform = transform
                    
                }, completion: { (animated: Bool) -> Void in
                    
                    flyView.transform = CGAffineTransformMakeTranslation(0, 500)
                    UIView.animateWithDuration(NSTimeInterval(1.0), delay: NSTimeInterval(0.0), options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                        
                        flyView.transform = CGAffineTransformIdentity
                        
                    }, completion: { (animated: Bool) -> Void in
                            
                        scrollView.userInteractionEnabled = true
                        self.footerFlyoutView.stopFlying()
                        self.view.sendSubviewToBack(self.footerFlyoutView)
                            
                    })
                    
                })
                
            }
            
        }
        
        // now let's figure out what parallax views are shown
        
        let visibleCells = self.tableView.visibleCells();
        for cell in visibleCells {
            
            if let parallaxCell = cell as? ParallaxStoryTableViewCell {
                
                let indexPath = self.tableView.indexPathForCell(parallaxCell)!
                let frame = self.tableView.rectForRowAtIndexPath(indexPath)
                let convertedFrame = self.tableView.convertRect(frame, toView: self.tableView.superview)
                
                let parallaxViewMidpoint = CGRectGetMidY(parallaxCell.parallaxView.bounds)
                let startBase = CGRectGetMinY(convertedFrame) + parallaxViewMidpoint
                let endBase = CGRectGetMaxY(convertedFrame) - parallaxViewMidpoint
            
                let maxOffset = CGRectGetMidY(self.view.bounds) + parallaxViewMidpoint
                
                // intro offset
                
                let introOffset = startBase - CGRectGetMidY(self.view.bounds)
                if introOffset > 0 {
                    
                    parallaxCell.introOffset = 1.0 - introOffset / maxOffset
                    
                } else {
                    
                    parallaxCell.introOffset = 1.0
                    
                }
                
                // main offset
                
                let offset = CGRectGetMidY(self.view.bounds) - startBase
                if offset > 0 {
                    
                    parallaxCell.offset = min(offset / (endBase - startBase), 1.0)
                    
                } else {
                    
                    parallaxCell.offset = 0.0
                    
                }
                
                // outro offset
                
                let outroOffset = CGRectGetMidY(self.view.bounds) - endBase
                if outroOffset > 0 {
                    
                    parallaxCell.outroOffset = min(outroOffset / maxOffset, 1.0)
                    
                } else {
                    
                    parallaxCell.outroOffset = 0.0
                    
                }
                
            }
            
        }
        
    }

}

// MARK: Data Source Helper

extension ViewController {
    
    func generateDataSource() -> StoryDataSource {
        
        let dataSource = StoryDataSource()
        
        // generate the first section
        
        var section = StoryDataSourceSection()
        section.addCell(WhitespaceTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            height /= 2.0
            return height
            
        }, cellSetupFunction: { (var cell) -> () in
            
            cell.backgroundColor = UIColor.clearColor()
            
        })
        section.addCell(WhitespaceTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            height /= 2.0
            height -= TextHeaderView.height
            height /= 2.0
            return height
            
        }, cellSetupFunction: nil)
        dataSource.addSection(section)
        
        // generate the about me section
        
        section = StoryDataSourceSection()
        
        var headerView = TextHeaderView()
        headerView.label.text = "Hello, I'm Aaron"
        headerView.frame = CGRectMake(0, 0, 0, TextHeaderView.height)
        section.headerView = headerView
        
        section.addCell(WhitespaceTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            height /= 2.0
            height -= TextHeaderView.height
            height /= 2.0
            return height
            
        }, cellSetupFunction: nil)
        section.addCell(AboutMeTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            return AboutMeTableViewCell.cellHeight
            
        }, cellSetupFunction: nil)
        dataSource.addSection(section)
        
        // generate the work section
        
        section = StoryDataSourceSection()
        section.addCell(WorkTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            return WorkTableViewCell.cellHeight
            
        }, cellSetupFunction: nil)
        dataSource.addSection(section)
        
        // generate the apps section
        
        section = StoryDataSourceSection()
        
        headerView = TextHeaderView()
        headerView.label.text = "I've built some things"
        headerView.frame = CGRectMake(0, 0, 0, TextHeaderView.height)
        section.headerView = headerView
        
        section.addCell(AppsTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            return AppsTableViewCell.cellHeight
            
        }, cellSetupFunction: nil)
        dataSource.addSection(section)
        
        // generate the WWDC section
        
        section = StoryDataSourceSection()
        
        headerView = TextHeaderView()
        headerView.label.text = "I'd love to go to WWDC"
        if !AppLayoutManager.isAppLarge {
            
            headerView.label.font = UIFont(name: "HelveticaNeue-Ultralight", size: 28.0)
            
        }
        headerView.frame = CGRectMake(0, 0, 0, TextHeaderView.height)
        section.headerView = headerView
        
        section.addCell(WWDCTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            return WWDCTableViewCell.cellHeight
            
        }, cellSetupFunction: nil)
        section.addCell(WhitespaceTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            height /= 2.0
            return height
            
        }, cellSetupFunction: nil)
        dataSource.addSection(section)
        
        // generate the transparent footer section
        
        section = StoryDataSourceSection()
        section.addCell(WhitespaceTableViewCell.self, heightFunction: { (var height) -> CGFloat in
            
            return FlyoutView.heightForWidth(CGRectGetWidth(UIScreen.mainScreen().bounds))
            
        }, cellSetupFunction: { (var cell) -> () in
                
            cell.backgroundColor = UIColor.clearColor()
                
        })
        dataSource.addSection(section)
        
        return dataSource
        
    }
    
}

// MARK: Image Helper

extension ViewController {
    
    func generateBlurredImage(image: UIImage, completionHandler: (UIImage)->()) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let filter = CIFilter(name: "CIGaussianBlur")
            filter.setDefaults()
            filter.setValue(CIImage(CGImage: image.CGImage), forKey: kCIInputImageKey)
            filter.setValue(NSNumber(integer: 4), forKey: kCIInputRadiusKey)
            
            let outputImage = filter.outputImage
            let context = CIContext(options: nil)
            
            var rect = outputImage.extent()
            
            let cgImage = context.createCGImage(outputImage, fromRect: rect)
            let finalImage = UIImage(CGImage: cgImage)
            
            dispatch_async(dispatch_get_main_queue()) {
                
                completionHandler(finalImage!)
            
            }
            
        }
        
    }
    
}
