#import "NSManagedObjectContextX.h"

@implementation NSManagedObjectContext (X)

- (NSManagedObject *)newObjectOfEntity:(NSString *)name
{
    return [NSManagedObject.alloc initWithEntity:[NSEntityDescription entityForName:name inManagedObjectContext:self] insertIntoManagedObjectContext:self];
}

- (NSArray *)objectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDecriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit
{
    NSFetchRequest *request = NSFetchRequest.new;
    
    request.entity = [NSEntityDescription entityForName:name inManagedObjectContext:self];
    request.predicate = predicate;
    request.fetchLimit = limit;
    
    if (sortDescriptors)
        request.sortDescriptors = sortDescriptors;
    
    return [self executeFetchRequest:request error:nil];
}

- (void)deleteObjectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDecriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit
{
    @try
    {
        NSArray *toRemove = [self objectsOfEntity:name withPredicate:predicate sortDecriptors:sortDescriptors andFetchLimit:limit];
        
        for (NSManagedObject *object in toRemove)
            [self deleteObject:object];
    }
    @catch (NSException *exception)
    {}
}

@end
