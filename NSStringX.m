#import "NSStringX.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (X)

typedef unsigned char * (* hashing_algorithm_t)(const void *data, CC_LONG len, unsigned char *hash);

- (NSString *)hashAs:(hashing_algorithm_t)algorithm withSize:(size_t)size
{
    if (!self.length)
        return nil;
    
    char const *bytes = self.UTF8String;
    unsigned char hash[size];
    
    algorithm(bytes, strlen(bytes), hash);
    
    NSMutableString *ret = [NSMutableString.alloc initWithCapacity:2 * size];
    
    for (NSInteger i = 0; i < size; ++i)
        [ret appendFormat:@"%02X", hash[i]];
    
    return ret;
}

- (NSString *)MD5
{
    return [self hashAs:CC_MD5 withSize:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)SHA256
{
    return [self hashAs:CC_SHA256 withSize:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)likeUUID
{
    NSMutableString *ret = self.uppercaseString.mutableCopy;
    
    if (0x20 != ret.length)  //length of UUID without dashes
        return @"";
    
    [ret insertString:@"-" atIndex:8];
    [ret insertString:@"-" atIndex:13];
    [ret insertString:@"-" atIndex:18];
    [ret insertString:@"-" atIndex:23];
    
    return ret;
}

@end
