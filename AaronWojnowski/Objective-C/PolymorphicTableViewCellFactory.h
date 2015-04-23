//
//  PolymorphicTableViewCellFactory.h
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-15.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolymorphicTableViewCellFactory : NSObject

+(UITableViewCell *)tableViewCellFromClass:(Class)class reuseIdentifier:(NSString *)reuseIdentifier;

@end
