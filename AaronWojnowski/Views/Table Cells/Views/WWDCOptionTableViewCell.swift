//
//  WWDCOptionTableViewCell.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-19.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class WWDCOptionTableViewCell: UITableViewCell {
    
    private static let padding: CGFloat = 16.0
    private static let caretWidth: CGFloat = 8.0
    
    private(set) lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        label.textColor = UIColor(white: 0.2, alpha: 1.0)
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
        
    }()
    
    private(set) lazy var caretImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "caretIcon")
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
    }
    
    required init(coder decoder: NSCoder) {
        
        fatalError("init(coder:) not implemented.")
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let labelWidth = WWDCOptionTableViewCell.labelWidthForWidth(CGRectGetWidth(self.contentView.bounds))
        
        self.titleLabel.frame = CGRectMake(0, 0, labelWidth, 0)
        self.titleLabel.sizeToFit()
        self.titleLabel.frame = CGRectMake(WWDCOptionTableViewCell.padding + 4, WWDCOptionTableViewCell.padding, labelWidth, CGRectGetHeight(self.titleLabel.frame))
        
        self.caretImageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + WWDCOptionTableViewCell.padding, 0, WWDCOptionTableViewCell.caretWidth, CGRectGetHeight(self.contentView.bounds))
        
    }
    
    // MARK: Class Methods
    
    static func labelWidthForWidth(width: CGFloat) -> CGFloat {
        
        return width - WWDCOptionTableViewCell.padding - 4 - WWDCOptionTableViewCell.padding - WWDCOptionTableViewCell.padding - WWDCOptionTableViewCell.caretWidth
        
    }
    
    static func heightForText(text: String, width: CGFloat) -> CGFloat {
        
        let labelWidth = self.labelWidthForWidth(width)
        
        var height = WWDCOptionTableViewCell.padding
        
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
        label.numberOfLines = 0
        
        label.frame = CGRectMake(0, 0, labelWidth, 0)
        label.text = text
        label.sizeToFit()
        
        height += CGRectGetHeight(label.bounds)
        height += WWDCOptionTableViewCell.padding
        
        return height
        
    }

}
