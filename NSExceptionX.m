#import "NSExceptionX.h"

#include <execinfo.h>

@implementation NSException (X)

- (NSArray *)backtrace
{
    NSArray *addresses = self.callStackReturnAddresses;
    unsigned count = addresses.count;
    void **stack = malloc(count * sizeof(void *));
    
    for (unsigned i = 0; i < count; ++i)
        stack[i] = (void *)[addresses[i] longValue];
    
    char **strings = backtrace_symbols(stack, count);
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; ++i)
	 	[ret addObject:@(strings[i])];
    
    free(stack);
    free(strings);
    
    return ret;
}

@end
