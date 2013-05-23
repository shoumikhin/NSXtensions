#import "NSUUIDX.h"

@implementation NSUUID (X)

+ (NSString *)makeUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);

    CFRelease(uuidRef);

    return (__bridge_transfer NSString *)uuid;
}

@end
