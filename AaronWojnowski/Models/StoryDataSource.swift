//
//  StoryDataSource.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-14.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class StoryDataSource: NSObject {
    
    private lazy var _sections: [StoryDataSourceSection] = []
    
    // MARK: Section Setup
    
    func addSection(section: StoryDataSourceSection) {
        
        self._sections.append(section)
        
    }
    
    // MARK: Section Getters & Setters
    
    func totalSections() -> Int {
        
        return self._sections.count
        
    }
    
    func sectionAtIndex(index: Int) -> StoryDataSourceSection {
        
        return self._sections[index];
        
    }
   
}
