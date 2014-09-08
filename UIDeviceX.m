#import "UIDeviceX.h"

#import <AdSupport/AdSupport.h>

#import "NSStringX.h"

#import <sys/utsname.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <mach/mach.h>

@implementation UIDevice (X)

+ (NSString *)machineName
{
    static NSString *machineName = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,
                  ^
                  {
                      struct utsname systemInfo;

                      uname(&systemInfo);

                      machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
                  });
    
    return machineName;
}

+ (NSString *)deviceName
{
    static NSDictionary *devices = nil;
    
    if (!devices)
        devices =
        @{
          @"i386"      : @"Simulator",
          @"x86_64"    : @"Simulator",
          @"iPad1,1"   : @"iPad Original",
          @"iPad2,1"   : @"iPad 2",
          @"iPad2,2"   : @"iPad 2",
          @"iPad2,3"   : @"iPad 2",
          @"iPad2,4"   : @"iPad 2",
          @"iPad2,5"   : @"iPad Mini",
          @"iPad2,6"   : @"iPad Mini",
          @"iPad2,7"   : @"iPad Mini",
          @"iPad3,1"   : @"iPad 3",
          @"iPad3,2"   : @"iPad 3",
          @"iPad3,3"   : @"iPad 3",
          @"iPad3,4"   : @"iPad 4",
          @"iPad3,5"   : @"iPad 4",
          @"iPad3,6"   : @"iPad 4",
          @"iPad4,1"   : @"iPad Air",    // Wifi
          @"iPad4,2"   : @"iPad Air",    // Cellular
          @"iPad4,4"   : @"iPad Mini 2", // Wifi
          @"iPad4,5"   : @"iPad Mini 2",  // Cellular
          @"iPhone1,1" : @"iPhone Original",
          @"iPhone1,2" : @"iPhone 3G",
          @"iPhone2,1" : @"iPhone 3GS",
          @"iPhone3,1" : @"iPhone 4",
          @"iPhone3,2" : @"iPhone 4",
          @"iPhone3,3" : @"iPhone 4",
          @"iPhone4,1" : @"iPhone 4S",
          @"iPhone5,1" : @"iPhone 5",    // (model A1428, AT&T/Canada)
          @"iPhone5,2" : @"iPhone 5",    // (model A1429, everything else)
          @"iPhone5,3" : @"iPhone 5C",   // (model A1456, A1532 | GSM)
          @"iPhone5,4" : @"iPhone 5C",   // (model A1507, A1516, A1526 (China), A1529 | Global)
          @"iPhone6,1" : @"iPhone 5S",   // (model A1433, A1533 | GSM)
          @"iPhone6,2" : @"iPhone 5S",   // (model A1457, A1518, A1528 (China), A1530 | Global)
          @"iPod1,1"   : @"iPod Touch Original",
          @"iPod2,1"   : @"iPod Touch 2",
          @"iPod3,1"   : @"iPod Touch 3",
          @"iPod4,1"   : @"iPod Touch 4",
          @"iPod5,1"   : @"iPod Touch 5"
         };

    NSString *ret = devices[self.machineName];

    if (!ret)
    {
        if (NSNotFound != [self.machineName rangeOfString:@"iPad (Unknown)"].location)
            ret = @"iPad";

        if (NSNotFound != [self.machineName rangeOfString:@"iPhone (Unknown)"].location)
            ret = @"iPhone";

        if (NSNotFound != [self.machineName rangeOfString:@"iPod (Unknown)"].location)
            ret = @"iPod Touch";
    }

    return ret;
}

+ (BOOL)isPhone
{
    return UIUserInterfaceIdiomPhone == self.class.currentDevice.userInterfaceIdiom;
}

+ (BOOL)isPhone4Inch
{
    return UIUserInterfaceIdiomPhone == self.class.currentDevice.userInterfaceIdiom && 568.0 == UIScreen.mainScreen.bounds.size.height;
}

+ (BOOL)isPad
{
    return UIUserInterfaceIdiomPad == self.class.currentDevice.userInterfaceIdiom;
}

+ (BOOL)isPad8Inch
{
    return  NSNotFound != [self.deviceName rangeOfString:@"iPad Mini"].location;
}

+ (BOOL)isSimulator
{
    return NSNotFound != [self.deviceName rangeOfString:@"Simulator"].location;
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

+ (NSString *)uniqueIdentifier
{
    if ([self.class systemVersionIsAtLeast:@"7.0"])
        return self.class.currentDevice.identifierForVendor.UUIDString;
    else
        return self.class.WiFiMACAddress.SHA256;
}

+ (double)availableMemory
{
	vm_statistics_data_t stats;
	mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
	kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&stats, &count);
    
	if (KERN_SUCCESS != kernReturn)
		return NSNotFound;
    
	return vm_page_size * stats.free_count / (double)0x100000;
}

+ (UIDeviceResolution)resolution
{
    BOOL isRetina = [UIScreen.mainScreen respondsToSelector:@selector(scale)];
    
    if (self.class.isPad)
        return isRetina ? UIDeviceResolutioniPadStandardHi : UIDeviceResolutioniPadStandard;
    else
        if (self.class.isPhone4Inch)
            return UIDeviceResolutioniPhoneTallerHi;
        else
            return isRetina ? UIDeviceResolutioniPhoneStandardHi : UIDeviceResolutioniPhoneStandard;
}

+ (BOOL)systemVersionIsAtLeast:(NSString *)version
{
    return NSOrderedAscending != [self.class.currentDevice.systemVersion compare:version options:NSNumericSearch];
}

@end
