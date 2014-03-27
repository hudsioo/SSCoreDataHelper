//
//  User.h
//  CoredataHelper
//
//  Created by hudsioo on 3/21/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CreditCrad;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSSet *user_cards;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUser_cardsObject:(CreditCrad *)value;
- (void)removeUser_cardsObject:(CreditCrad *)value;
- (void)addUser_cards:(NSSet *)values;
- (void)removeUser_cards:(NSSet *)values;

@end
