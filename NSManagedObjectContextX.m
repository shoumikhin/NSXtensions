#import "NSManagedObjectContextX.h"

@implementation NSManagedObjectContext (X)

- (NSManagedObject *)newObjectOfEntity:(NSString *)name
{
    return [NSManagedObject.alloc initWithEntity:self.persistentStoreCoordinator.managedObjectModel.entitiesByName[name] insertIntoManagedObjectContext:self];
}

- (NSArray *)objectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit
{
    NSFetchRequest *request = NSFetchRequest.new;

    request.entity = self.persistentStoreCoordinator.managedObjectModel.entitiesByName[name];
    request.predicate = predicate;
    request.fetchLimit = limit;
    
    if (sortDescriptors)
        request.sortDescriptors = sortDescriptors;
    
    return [self executeFetchRequest:request error:nil];
}

- (void)deleteObjects:(NSArray *)objects
{
    for (NSManagedObject *object in objects)
    @try
    {
        [self deleteObject:object];
    }
    @catch (NSException *exception)
    {}
}

- (void)deleteObjectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit
{
    [self deleteObjects:[self objectsOfEntity:name withPredicate:predicate sortDescriptors:sortDescriptors andFetchLimit:limit]];
}

@end
