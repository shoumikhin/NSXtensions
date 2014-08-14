#import "NSUUIDX.h"

@implementation NSUUID (X)

+ (NSString *)makeUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);

    CFRelease(uuidRef);

    return (__bridge_transfer NSString *)uuid;
}

@end
