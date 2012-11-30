#import "NSManagedObjectContextX.h"

@implementation NSManagedObjectContext (X)

- (NSManagedObject *)newObjectOfEntity:(NSString *)name
{
    return [NSManagedObject.alloc initWithEntity:[NSEntityDescription entityForName:name inManagedObjectContext:self] insertIntoManagedObjectContext:self];
}

- (NSArray *)objectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDecriptors:(NSArray *)sortDescriptors anndFetchLimit:(NSUInteger)limit
{
    NSFetchRequest *request = NSFetchRequest.new;
    
    request.entity = [NSEntityDescription entityForName:name inManagedObjectContext:self];
    request.predicate = predicate;
    request.fetchLimit = limit;
    
    if (sortDescriptors)
        [request setSortDescriptors:sortDescriptors];
    
    return [self executeFetchRequest:request error:nil];
}

- (void)deleteObjectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate andSortDecriptors:(NSArray *)sortDescriptors
{
    @try
    {
        NSArray *toRemove = [self objectsOfEntity:name withPredicate:predicate sortDecriptors:sortDescriptors anndFetchLimit:0];
        
        for (NSManagedObject *object in toRemove)
            [self deleteObject:object];
    }
    @catch (NSException *exception)
    {}
}

@end
