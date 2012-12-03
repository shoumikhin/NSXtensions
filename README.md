NSXtensions
===========

A collection of useful extensions for standard Cocoa classes. Pull requests are welcome! :)

Simply add:

    #import <NSXtensions.h>

to your precompiled header, and you'll boost Cocoa with the following stuff (in alphabetical order):

### MKMapView

    - (NSInteger)zoomLevel;  //get the current zoom level
    
    //change map's location and zoom level
    - (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;

### NSDate

    //helper methods whose names speak for themselves
    - (NSInteger)secondsAfterDate:(NSDate *)date;
    - (NSInteger)minutesAfterDate:(NSDate *)date;
    - (NSInteger)minutesBeforeDate:(NSDate *)date;
    - (NSInteger)hoursAfterDate:(NSDate *)date;
    - (NSInteger)hoursBeforeDate:(NSDate *)date;
    - (NSInteger)daysAfterDate:(NSDate *)date;
    - (NSInteger)daysBeforeDate:(NSDate *)date;

### NSException
    
    - (NSArray *)backtrace;  //pretty-formatted stack trace
    
### NSFileManager

    //get standard directories paths and URLs
    + (NSURL *)documentsURL;
    + (NSString *)documentsPath;
    + (NSURL *)libraryURL;
    + (NSString *)libraryPath;
    + (NSURL *)cachesURL;
    + (NSString *)cachesPath;
    
    + (BOOL)addSkipBackupAttributeToFile:(NSString *)path;  //prevent syncing with iCloud
    
    + (double)availableDiskSpace;  //check available disk space (Megabytes)
    
### NSManagedObjectContext

    //create new object
    - (NSManagedObject *)newObjectOfEntity:(NSString *)name;
    
    //fetch objects with options, zero limit means unlimited
    - (NSArray *)objectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate sortDecriptors:(NSArray *)sortDescriptors andFetchLimit:(NSUInteger)limit;
    
    //delete objects with options
    - (void)deleteObjectsOfEntity:(NSString *)name withPredicate:(NSPredicate *)predicate andSortDecriptors:(NSArray *)sortDescriptors;

### NSMutableArray

    - (void)shuffle;  //randomly mix contents
    
    //use as queue ADT
    - (void)enqueue:(id)anObject;
    - (id)dequeue;
    
    //use as stack ADT
    - (void)push:(id)anObject;
    - (id)pop;

### NSSet

    - (NSDictionary *)indexedDictionary;  //returns a dictionary with integer keys and all objects in set as values

### NSString

    //hash of contents
    - (NSString *)MD5;
    - (NSString *)SHA256;

    - (NSString *)likeUUID;  //helper to insert dashes in 32-chars length string to make it look like UUID

### UIApplication

    + (NSString *)identifier;  //application's bundle identifier
    + (NSString *)version;  //application's bundle version
    
    + (CGRect)frame;  //application's frame regardless current orientation

    + (NSArray *)backtrace;  //pretty-formatted backtrace of current point of execution

### UIDevice

    //get MAC addresses of installed network interfaces
    + (NSString *)WiFiMACAddress;
    + (NSString *)CellularMACAddress;
    
    + (NSString *)uniqueIdentifier;  //globally unique device identifier (actually SHA256 of Wi-Fi MAC address)
    
    + (double)availableMemory;  //how much of free memory remains in system (Megabytes)


### UIView

    - (UIViewController *)viewController;  //returns a parent view controller
    - (BOOL)findAndResignFirstResponder;  //resigns the first responder, if found in this view hierarchy
    
### UIWebView

    //load HTML content with specific font
    - (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL font:(UIFont *)font;
    
    - (void)clearCookies;  //clear all saved cookies
