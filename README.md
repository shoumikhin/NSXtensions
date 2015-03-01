[![Stories in Ready](https://badge.waffle.io/shoumikhin/nsxtensions.png?label=ready&title=Ready)](https://waffle.io/shoumikhin/nsxtensions)&nbsp;
![Pod Platform](http://cocoapod-badges.herokuapp.com/p/NSXtensions/badge.png)&nbsp; 
![Pod Version](http://cocoapod-badges.herokuapp.com/v/NSXtensions/badge.png)

# NSXtensions

A collection of useful categories for standard Cocoa classes. Also available among CocoaPods.

Pull requests are welcome! :)

## Usage

Simply add the following line to your precompiled header:

```objc
#import <NSXtensions.h>
```

And you'll boost the following Cocoa classes (in alphabetical order):

* [MacroX](#macroxh)
* [MKMapView](#mkmapview)
* [NSDate](#nsdate)
* [NSDictionary](#nsdictionary)
* [NSError](#nserror)
* [NSException](#nsexception)
* [NSFileManager](#nsfilemanager)
* [NSIndexPath](#nsindexpath)
* [NSManagedObjectContext](#nsmanagedobjectcontext)
* [NSMutableArray](#nsmutablearray)
* [NSObject](#nsobject)
* [NSSet](#nsset)
* [NSString](#nsstring)
* [NSURL](#nsurl)
* [NSUUID](#nsuuid)
* [UIAlertView](#uialertview)
* [UIApplication](#uiapplication)
* [UIButton](#uibutton)
* [UIDevice](#uidevice)
* [UIImage](#uiimage)
* [UINavigationController](#uinavigationcontroller)
* [UITabBarController](#uitabbarcontroller)
* [UIView](#uiview)
* [UIWebView](#uiwebview)

## Details

#### MacroX.h

Precompile definitions for some commonly-used boilerplate code.

* Mark a line of code with a "TODO" or "FIXME" prefixed compiler warning:

```objc
TODO(message)
FIXME(message)
```

* Create and show a UIAlertView with the given values:

```objc
SHOW_ALERT(title, message, delegate, cancelButtonTitle, ...)
```

> *Example:*

> ```objc
> UIAlertView *alert = SHOW_ALERT(@"Title", @"And message", nil, @"OK", @"Other");

> [alert dismissWithClickedButtonIndex:0 animated:YES];
> ```

* Rapidly implement a read-only static property of a given type and name.

```objc
SYNTHESIZE_STATIC_PROPERTY(_type_, _name_, ...)
```

> *Example:*

> ```objc
> SYNTHESIZE_STATIC_PROPERTY(NSString *, bundleID,
> {
> 	NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];

> 	return bundleID;
> })
> ```

* Synthesize boilerplate code for a given class to support the singleton design pattern:

```objc
SYNTHESIZE_SINGLETON_FOR_CLASS(classname)
```

> *Example:*

> ```objc
> @implementation MyClass SYNTHESIZE_SINGLETON_FOR_CLASS(MyClass)
>   + (instancetype)init
>   {
>       //custom initialization
>  }
> @end

> void foo()
> {
> 	MyClass.shared.bar = @"Singleton";
> }
> ```

#### MKMapView

```objc
//get the current zoom level
- (NSInteger)zoomLevel;

//change map's location and zoom level
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;
```

#### NSDate

```objc
//helper methods whose names speak for themselves
+ (unsigned long long)millisecondsSince1970;
- (NSInteger)secondsAfterDate:(NSDate *)date;
- (NSInteger)minutesAfterDate:(NSDate *)date;
- (NSInteger)minutesBeforeDate:(NSDate *)date;
- (NSInteger)hoursAfterDate:(NSDate *)date;
- (NSInteger)hoursBeforeDate:(NSDate *)date;
- (NSInteger)daysAfterDate:(NSDate *)date;
- (NSInteger)daysBeforeDate:(NSDate *)date;
```

#### NSDictionary

```objc
//merge two dictionaries
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)first with:(NSDictionary *)second;
- (NSDictionary *)mergeWith:(NSDictionary *)other;
```

#### NSError

```objc
//a friendly human-readable localized description
- (NSString *)friendlyLocalizedDescription;

//create an NSError object with given domain, code and userInfo with a friendly human-readable localized description for known domains and codes
+ (instancetype)friendlyErrorWithDomain:(NSString *)domain andCode:(NSInteger)code;
```

#### NSException

```objc
//pretty-formatted stack trace
- (NSArray *)backtrace;
```

#### NSFileManager

```objc
//get standard directories paths and URLs
+ (NSURL *)documentsURL;
+ (NSString *)documentsPath;
+ (NSURL *)libraryURL;
+ (NSString *)libraryPath;
+ (NSURL *)cachesURL;
+ (NSString *)cachesPath;

//prevent syncing with iCloud
+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

//check available disk space (Megabytes)
+ (double)availableDiskSpace;
```

#### NSIndexPath

```objc
//convert index path to a string like "1.2.3.4" and back
+ (NSIndexPath *)indexPathWithString:(NSString *)path;
- (NSString *)stringValue;

//convenience methonds
- (NSUInteger)firstIndex;
- (NSUInteger)lastIndex;
```

#### NSManagedObjectContext

```objc
//create new object
- (NSManagedObject *)newObjectOfEntity:(NSString *)name;

//fetch objects with options, zero limit means unlimited
- (NSArray *)objectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit;

//delete multiple objects
- (void)deleteObjects:(NSArray *)objects;

//delete objects with options
- (void)deleteObjectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate andSortDescriptors:(NSArray *)sortDescriptors;
```

#### NSMutableArray

```objc
//a new array storing weak references to objects
+ (id)arrayUsingWeakReferences;
+ (id)arrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity;

//randomly mix contents
- (void)shuffle;

//use as queue ADT
- (void)enqueue:(id)anObject;
- (id)dequeue;

//use as stack ADT
- (void)push:(id)anObject;
- (id)pop;
```

#### NSObject

```objc
//add or change methods in run-time
+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)aClass;
+ (void)replaceMethod:(SEL)aMethod fromClass:(Class)aClass;

//check whether an object or class implements or inherits a specified method up to and exluding a particular class in hierarchy
- (BOOL)respondsToSelector:(SEL)selector untilClass:(Class)stopClass;
- (BOOL)superRespondsToSelector:(SEL)selector;
- (BOOL)superRespondsToSelector:(SEL)selector untilClass:(Class)stopClass;
+ (BOOL)instancesRespondToSelector:(SEL)selector untilClass:(Class)stopClass;
```

#### NSSet

```objc
//returns a dictionary with integer keys and all objects in set as values
- (NSDictionary *)indexedDictionary;
```

#### NSString

```objc
//first substring that matches a given regular expression
- (NSString *)substringWithRegularExpressionPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

//short and smart way to deal with URL percent escapes
- (NSString *)URLEncoded;
- (NSString *)URLDecoded;

//hash of contents
- (NSString *)MD5;
- (NSString *)SHA256;

//helper to insert dashes in 32-chars length string to make it look like UUID
- (NSString *)likeUUID;
```

#### NSURL

```objc
//get base host URL
- (NSURL *)hostURL;
```

#### NSUUID

```objc
//generate a new unique identifier
+ (NString *)makeUUID;
```

#### UIAlertView

```objc
//display an alert and execute a completion block on dismiss
- (void)showWithCompletion:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))completionBlock;
```

#### UIApplication

```objc
//application's bundle identifier
+ (NSString *)identifier;
//application's bundle version
+ (NSString *)version;

//application's frame regardless current orientation
+ (CGRect)frame;
//application's status bar height
+ (CGFloat)statusBarHeight;

//pretty-formatted backtrace of current point of execution
+ (NSArray *)backtrace;

//call, email or open ULR with an ability to quickly return back
+ (void)call:(NSString *)phoneNumber andShowReturn:(BOOL)shouldReturn;
+ (void)email:(NSString *)address andShowReturn:(BOOL)shouldReturn;
+ (void)openURL:(NSURL *)url andShowReturn:(BOOL)shouldReturn;
```

#### UIButton

```objc
//set a title for all UIControl states at once
- (void)setTitleForAllStates:(NSString *)title;

//set an image for all UIControl states at once
- (void)setImageForAllStates:(UIImage *)image;
```

#### UIColor

```objc
//convert "#RRGGBB" to UIColor
+ (UIColor *)colorWithHTMLColor:(NSString *)HTMLColor;
```

#### UIDevice

```objc
//globally unique device identifier (SHA256 of Wi-Fi MAC address before iOS 7.0, and identifier for vendor now)
+ (NSString *)uniqueIdentifier;

//hadrware device name
+ (NSString *)machineName;
//human readable device name
+ (NSString *)deviceName;

//check if a specific system version is supported
+ (BOOL)systemVersionIsAtLeast:(NSString *)version;

//get the screen resolution of the device
+ (UIResolution)resolution;

//how much of free memory remains in system (Megabytes)
+ (double)availableMemory;

//check the device type
+ (BOOL)isSimulator;
+ (BOOL)isPhone;
+ (BOOL)isPad;
+ (BOOL)isPod;
+ (BOOL)isAppleTV;

//check if the device is cracked
+ (BOOL)isJailbroken;

//get the MAC addresses of installed network interfaces (deprecated)
+ (NSString *)WiFiMACAddress;
+ (NSString *)CellularMACAddress;
```

#### UIImage

```objc
//convenient way to download an image
- (id)initWithContentsOfURL:(NSURL *)URL;
+ (id)imageWithContentsOfURL:(NSURL *)URL;

//applies the blur effect to the image
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

//returns a new image representing a cropped part of the original
- (UIImage *)cropToRect:(CGRect)rect;
```

#### UINavigationController

```objc
//animates navigation action with custom CoreAnimation transitions
- (void)pushViewController:(UIViewController *)viewController withTransitionType:(NSString *)type;
- (UIViewController *)popViewControllerWithTransitionType:(NSString *)type;
- (NSArray *)popToRootViewControllerWithTransitionType:(NSString *)type;
- (NSArray *)popToViewController:(UIViewController *)viewController withTransitionType:(NSString *)type;
```

#### UITabBarController

```objc
//methods to hide/show the tab bar similarly to the standard navigation bar behavior
@property (nonatomic, getter = isTabBarHidden) BOOL tabBarHidden;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

//animated swipe-like transition between presented view controllers
- (void)swipeToIndex:(NSUInteger)index;
```

#### UIView

```objc
//a convenient way to control UIView's frame
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGPoint origin;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat dx;
@property (nonatomic) CGFloat dy;
@property (nonatomic) CGVector bound;

//returns a parent view controller
- (UIViewController *)viewController;
//resigns the first responder, if found in this view hierarchy
- (BOOL)resignFirstResponderRecursively;

//find a superview of specific class
- (UIView *)superviewOfClass:(Class)aClass;

//move with animation
- (void)moveTo:(CGPoint)destination duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options;
```

#### UIWebView

```objc
//load HTML content with specific font
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL font:(UIFont *)font;

//clear all saved cookies
- (void)clearCookies;
```
