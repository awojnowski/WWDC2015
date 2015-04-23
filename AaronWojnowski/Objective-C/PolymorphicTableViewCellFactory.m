//
//  PolymorphicTableViewCellFactory.m
//  AaronWojnowski
//
//  Created by Aaron Wojnowski on 2015-04-15.
//  Copyright (c) 2015 Aaron Wojnowski. All rights reserved.
//

#import "PolymorphicTableViewCellFactory.h"

@implementation PolymorphicTableViewCellFactory

+(UITableViewCell *)tableViewCellFromClass:(Class)class reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
}

@end
