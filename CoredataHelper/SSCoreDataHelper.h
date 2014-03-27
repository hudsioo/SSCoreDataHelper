//
//  SSCoreDataHelper.h
//  CoredataHelper
//
//  Created by hudsioo on 3/18/2557 BE.
//  Copyright (c) 2557 QOOFHOUSE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCoreDataHelper : NSObject<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


+ (SSCoreDataHelper *)sharedInstance;

//Retrive From CoreData
- (NSMutableArray *)getDataForEntity:(NSString *)entityName withSortKey:(NSString *)sortKey andSortAscending:(BOOL)sortAscending;
- (NSMutableArray *)searchForEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate andSortKey:(NSString *)sortKey andSortAscending:(BOOL)sortAscending;


//Insert To CoreData
-(BOOL)insertToEntity:(NSString*)entityName withObject:(NSMutableDictionary*)object;

//Delete Record
-(BOOL)deleteEntity:(NSString*)entityName withObject:(NSManagedObject*)object;

@end
