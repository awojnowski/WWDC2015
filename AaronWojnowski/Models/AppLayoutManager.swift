//
//  AppLayoutManager.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-18.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class AppLayoutManager: NSObject {
    
    private static let largeThresholdHeight: CGFloat = 568
    private(set) static var isAppLarge = {
        
        return CGRectGetHeight(UIScreen.mainScreen().bounds) > AppLayoutManager.largeThresholdHeight
        
    }()
   
}
