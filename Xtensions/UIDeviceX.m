#import "UIDeviceX.h"

#import <AdSupport/AdSupport.h>

#import "MacroX.h"
#import "NSStringX.h"

#import <sys/utsname.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <mach/mach.h>

@implementation UIDevice (X)

SYNTHESIZE_STATIC_PROPERTY(NSString *, uniqueIdentifier,
{
#if defined(__IPHONE_7_0)
    return self.class.currentDevice.identifierForVendor.UUIDString;
#else
    return self.class.WiFiMACAddress.SHA256;
#endif
})
    
SYNTHESIZE_STATIC_PROPERTY(NSString *, machineName,
{
    struct utsname systemInfo;

    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
})

SYNTHESIZE_STATIC_PROPERTY(NSString *, deviceName,
{
    NSString *deviceName =
        @{
          @"i386"      : @"Simulator",
          @"x86_64"    : @"Simulator",
          @"AppleTV2,1": @"AppleTV 2",
          @"AppleTV3,1": @"AppleTV 3",
          @"iPad1,1"   : @"iPad Original",
          @"iPad2,1"   : @"iPad 2",
          @"iPad2,2"   : @"iPad 2 GSM",
          @"iPad2,3"   : @"iPad 2 CDMA",
          @"iPad2,4"   : @"iPad 2",
          @"iPad2,5"   : @"iPad Mini",
          @"iPad2,6"   : @"iPad Mini GSM",
          @"iPad2,7"   : @"iPad Mini CDMA",
          @"iPad3,1"   : @"iPad 3",
          @"iPad3,2"   : @"iPad 3 GSM",
          @"iPad3,3"   : @"iPad 3 CDMA",
          @"iPad3,4"   : @"iPad 4",
          @"iPad3,5"   : @"iPad 4 GSM",
          @"iPad3,6"   : @"iPad 4 CDMA",
          @"iPad4,1"   : @"iPad Air",
          @"iPad4,2"   : @"iPad Air GSM",
          @"iPad4,3"   : @"iPad Air CDMA",
          @"iPad4,4"   : @"iPad Mini 2",
          @"iPad4,5"   : @"iPad Mini 2 GSM",
          @"iPad4,6"   : @"iPad Mini 2 CDMA",
          @"iPhone1,1" : @"iPhone Original",
          @"iPhone1,2" : @"iPhone 3G",
          @"iPhone2,1" : @"iPhone 3GS",
          @"iPhone3,1" : @"iPhone 4",
          @"iPhone3,2" : @"iPhone 4",
          @"iPhone3,3" : @"iPhone 4",
          @"iPhone4,1" : @"iPhone 4S",
          @"iPhone4,2" : @"iPhone 4S",
          @"iPhone4,3" : @"iPhone 4S",
          @"iPhone5,1" : @"iPhone 5",
          @"iPhone5,2" : @"iPhone 5",
          @"iPhone5,3" : @"iPhone 5C",
          @"iPhone5,4" : @"iPhone 5C",
          @"iPhone6,1" : @"iPhone 5S",
          @"iPhone6,2" : @"iPhone 5S",
          @"iPod1,1"   : @"iPod Touch Original",
          @"iPod2,1"   : @"iPod Touch 2",
          @"iPod3,1"   : @"iPod Touch 3",
          @"iPod4,1"   : @"iPod Touch 4",
          @"iPod5,1"   : @"iPod Touch 5"
    }
    [self.machineName];

    if (!deviceName)
    {
        if (NSNotFound != [self.machineName rangeOfString:@"AppleTV"].location)
            deviceName = @"Apple TV (Unknown)";

        if (NSNotFound != [self.machineName rangeOfString:@"iPad"].location)
            deviceName = @"iPad (Unknown)";

        if (NSNotFound != [self.machineName rangeOfString:@"iPhone"].location)
            deviceName = @"iPhone (Unknown)";

        if (NSNotFound != [self.machineName rangeOfString:@"iPod"].location)
            deviceName = @"iPod Touch (Unknown)";
    }

    return deviceName;
})

+ (BOOL)systemVersionIsAtLeast:(NSString *)version
{
    return NSOrderedAscending != [self.class.currentDevice.systemVersion compare:version options:NSNumericSearch];
}

SYNTHESIZE_STATIC_PROPERTY(UIResolution, resolution,
{
    int height = UIScreen.mainScreen.bounds.size.height * UIScreen.mainScreen.scale;

    return  480 == height ? UIResolutioniPhone :
    960 == height ? UIResolutioniPhone2X :
    1136 == height ? UIResolutioniPhoneHi2X :
    1704 == height ? UIResolutioniPhoneHi3X :
    1536 == height ? UIResolutioniPad2X :
    UIResolutionUnknown;
})

+ (double)availableMemory
{
    vm_statistics_data_t stats;
    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&stats, &count);

    if (KERN_SUCCESS != kernReturn)
        return NSNotFound;

    return vm_page_size * stats.free_count / (double)0x100000;
}

+ (BOOL)isSimulator
{
    return NSNotFound != [self.deviceName rangeOfString:@"Simulator"].location;
}

+ (BOOL)isPhone
{
    return NSNotFound != [self.deviceName rangeOfString:@"iPhone"].location;
}

+ (BOOL)isPad
{
    return NSNotFound != [self.deviceName rangeOfString:@"iPad"].location;
}

+ (BOOL)isPod
{
    return NSNotFound != [self.deviceName rangeOfString:@"iPod"].location;
}

+ (BOOL)isAppleTV
{
    return NSNotFound != [self.deviceName rangeOfString:@"Apple TV"].location;
}

+ (BOOL)isJailbroken
{
    if (!self.class.isSimulator)
    {
        if ([NSFileManager.defaultManager fileExistsAtPath:@"/private/var/lib/apt/"])
            return YES;

        if (!NSBundle.mainBundle.infoDictionary[@"SignerIdentity"])
            return YES;
    }

    return NO;
}

+ (NSString *)MacAddressOfInterface:(NSString *)interface
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *mac;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if (!(mib[5] = if_nametoindex(interface.UTF8String)))
        return nil;

    if (0 > sysctl(mib, 6, NULL, &len, NULL, 0))
        return nil;

    buf = malloc(len);

    if (0 > sysctl(mib, 6, buf, &len, NULL, 0))
    {
        free(buf);
        
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    mac = (unsigned char *)LLADDR(sdl);
    
    NSString *ret = [NSString.alloc initWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]];
    
    free(buf);
    
    return ret;
}

+ (NSString *)WiFiMACAddress
{
    return [self MacAddressOfInterface:@"en0"];
}

+ (NSString *)CellularMACAddress
{
    return [self MacAddressOfInterface:@"pdp_ip0"];
}

@end
