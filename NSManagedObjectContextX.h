//
//  NSManagedObjectContextX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (X)

/**
 Create a new object with entiry name.
 
 @param name Entiry name of the object.
 @return A new NSManagedObject.
 */
- (NSManagedObject *)newObjectOfEntity:(NSString *)name;

/**
 Get an array of objects.
 
 @param name Entiry name of the object.
 @param predicate NSPredicate to fetch the objects.
 @param sortDescriptors A list of sorting rules.
 @param limit A fetch limit of objects to return. Zero means unlimited.
 @return An array of fetched objects.
 */
- (NSArray *)objectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit;

/**
 Delete several objects.
 
 @param objects Objects to delete.
 */
- (void)deleteObjects:(NSArray *)objects;

/**
 Delete several objects.
 
 @param name Entiry name of the object.
 @param predicate NSPredicate to fetch the objects to be removed.
 @param sortDescriptors A list of sorting rules.
 @param limit A fetch limit of objects to delete. Zero means unlimited.
 */
- (void)deleteObjectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit;

@end
