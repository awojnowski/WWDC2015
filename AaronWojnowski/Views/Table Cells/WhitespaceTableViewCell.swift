//
//  WhitespaceTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-14.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class WhitespaceTableViewCell: StoryTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
}
