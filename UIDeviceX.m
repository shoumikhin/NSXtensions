#import "UIDeviceX.h"

#import "NSStringX.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <mach/mach.h>

@implementation UIDevice (X)

+ (BOOL)isPhone
{
    return UIUserInterfaceIdiomPhone == UIDevice.currentDevice.userInterfaceIdiom;
}

+ (BOOL)isPhone4Inch
{
    return UIUserInterfaceIdiomPhone == UIDevice.currentDevice.userInterfaceIdiom && 568.0 == UIScreen.mainScreen.bounds.size.height;
}

+ (BOOL)isPad
{
    return UIUserInterfaceIdiomPad == UIDevice.currentDevice.userInterfaceIdiom;
}

+ (BOOL)isPad8Inch
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString.alloc initWithUTF8String:machine];
    
    free(machine);
    
    return [platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"];
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
    return UIDevice.WiFiMACAddress.SHA256;
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

@end
