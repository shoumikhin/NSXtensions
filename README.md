NSXtensions
===========

A collection of useful extensions for standard Cocoa classes. Pull requests are welcome! :)

Simply add:

    #import <NSXtensions.h>

to your precompiled header, and you'll boost Cocoa with the following stuff (in alphabetical order):

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
