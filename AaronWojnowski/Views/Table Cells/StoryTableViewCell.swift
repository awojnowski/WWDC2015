//
//  StoryTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-14.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate {
    
    func storyTableViewCellPushedViewController(storyTableViewCell: StoryTableViewCell, viewController: UIViewController)
    func storyTableViewCellPresentedViewController(storyTableViewCell: StoryTableViewCell, viewController: UIViewController)
    
}

class StoryTableViewCell: UITableViewCell {
    
    var delegate: StoryTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }

}
