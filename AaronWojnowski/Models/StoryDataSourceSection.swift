//
//  StoryDataSourceSection.swift
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-14.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

import UIKit

class StoryDataSourceSection: NSObject {
    
    private lazy var _rows: [StoryDataSourceSectionCell] = []
    var headerView: UIView?
    
    func addCell(cellClass: AnyClass, heightFunction: (CGFloat)->(CGFloat), cellSetupFunction: ((UITableViewCell)->())?) {
        
        let cell = StoryDataSourceSectionCell()
        cell.cellClass = cellClass
        cell.heightFunction = heightFunction
        cell.cellSetupFunction = cellSetupFunction
        self._rows.append(cell)
        
    }
    
    // MARK: Cell Setup
    
    func setupCell(index: Int, cell: UITableViewCell) {
        
        if let function = self._rows[index].cellSetupFunction {
            
            function(cell)
            
        }
        
    }
    
    // MARK: Getters & Setters
    
    func totalRows() -> Int {
        
        return self._rows.count
        
    }
    
    func cellClassAtIndex(index: Int) -> AnyClass {
        
        return self._rows[index].cellClass!
        
    }
    
    func heightForRowAtIndex(index: Int, height: CGFloat) -> CGFloat {
        
        return (self._rows[index].heightFunction)!(height)
        
    }
    
}

class StoryDataSourceSectionCell: NSObject {
    
    var cellClass: AnyClass?
    var heightFunction: ((CGFloat) -> (CGFloat))?
    var cellSetupFunction: ((UITableViewCell) -> ())?
    
}
