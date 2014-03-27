//
//  CreditCrad.h
//  CoredataHelper
//
//  Created by hudsioo on 3/21/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface CreditCrad : NSManagedObject

@property (nonatomic, retain) NSString * card_id;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) User *user;

@end
