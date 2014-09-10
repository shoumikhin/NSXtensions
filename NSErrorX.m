#import "NSErrorX.h"

#import "MacroX.h"
#import "NSDictionaryX.h"

#import <Foundation/FoundationErrors.h>
#import <CoreData/CoreDataErrors.h>
#import <CFNetwork/CFNetworkErrors.h>
#import <Foundation/NSURLError.h>
#import <sqlite3.h>
#import <errno.h>
#import <mach/kern_return.h>

#if !TARGET_OS_IPHONE
    #import <AppKit/AppKitErrors.h>
#endif

@implementation NSError (X)

+ (NSDictionary *)_friendlyAppKitErrorsDescriptions
{
    return @{
#if !TARGET_OS_IPHONE
             @(NSTextReadInapplicableDocumentTypeError) :
                 @"There's a problem reading data with the specified format.",
             
             @(NSTextWriteInapplicableDocumentTypeError) :
                 @"There's a problem writing data of the specified format.",
             
             @(NSServiceApplicationNotFoundError) :
                 @"The service provider could not be found.",
             
             @(NSServiceApplicationLaunchFailedError) :
                 @"The service providing application could not be launched.",
             
             @(NSServiceRequestTimedOutError) :
                 @"The service providing application did not open its service listening port in time, or the app didn't respond to the request in time.",
             
             @(NSServiceInvalidPasteboardDataError) :
                 @"The service providing app did not return a pasteboard with any of the promised types, or we couldn't write the data from the pasteboard to the object receiving the returned data.",
             
             @(NSServiceMalformedServiceDictionaryError) :
                 @"The service dictionary did not contain the necessary keys.",
             
             @(NSServiceMiscellaneousError) :
                 @"There're programmatic mistakes in the service consuming application.",

             @(NSSharingServiceNotConfiguredError) :
                 @"The service is not configured in the Preferences."
#endif
            };
}

+ (NSDictionary *)_friendlyFoundationErrorsDescriptions
{
    return @{
             @(NSFileNoSuchFileError) :
                 @"File-system operation attempted on non-existent file.",

             @(NSFileLockingError) :
                 @"Failure to get a lock on file.",

             @(NSFileReadUnknownError) :
                 @"Read error, reason unknown.",

             @(NSFileReadNoPermissionError) :
                 @"Read error because of a permission problem.",

             @(NSFileReadInvalidFileNameError) :
                 @"Read error because of an invalid file name.",

             @(NSFileReadCorruptFileError) :
                 @"Read error because of a corrupted file, bad format, or similar reason.",

             @(NSFileReadNoSuchFileError) :
                 @"Read error because no such file was found.",

             @(NSFileReadInapplicableStringEncodingError) :
                 @"Read error because the string encoding was not applicable.",

             @(NSFileReadUnsupportedSchemeError) :
                 @"Read error because the specified URL scheme is unsupported.",

             @(NSFileReadTooLargeError) :
                 @"Read error because the specified file was too large.",

             @(NSFileReadUnknownStringEncodingError) :
                 @"Read error because the string coding of the file could not be determined.",

             @(NSFileWriteUnknownError) :
                 @"Write error, reason unknown.",

             @(NSFileWriteNoPermissionError) :
                 @"Write error because of a permission problem.",

             @(NSFileWriteInvalidFileNameError) :
                 @"Write error because of an invalid file name.",

             @(NSFileWriteFileExistsError) :
                 @"Write error returned when NSFileManager class’s copy, move, and link methods report errors when the destination file already exists.",

             @(NSFileWriteInapplicableStringEncodingError) :
                 @"Write error because the string encoding was not applicable.",

             @(NSFileWriteUnsupportedSchemeError) :
                 @"Write error because the specified URL scheme is unsupported.",

             @(NSFileWriteOutOfSpaceError) :
                 @"Write error because of a lack of disk space.",

             @(NSFileWriteVolumeReadOnlyError) :
                 @"Write error because because the volume is read only.",

             @(NSKeyValueValidationError) :
                 @"Key-value coding validation error.",

             @(NSFormattingError) :
                 @"Formatting error.",

             @(NSUserCancelledError) :
                 @"The user cancelled the operation.",

             @(NSPropertyListReadCorruptError) :
                 @"An error was encountered while parsing the property list.",

             @(NSPropertyListReadUnknownVersionError) :
                 @"The version number of the property list is unable to be determined.",

             @(NSPropertyListReadStreamError) :
                 @"An stream error was encountered while reading the property list.",

             @(NSPropertyListWriteStreamError) :
                 @"An stream error was encountered while writing the property list.",
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
             @(NSPropertyListWriteInvalidError) :
                 @"Invalid property list object or invalid property list type specified when writing.",
#endif
             @(NSPropertyListErrorMinimum) :
                 @"Marks beginning of the range of error codes reserved for property list errors.",

             @(NSPropertyListErrorMaximum) :
                 @"Marks end of the range of error codes reserved for property list errors.",
#if defined(__IPHONE_6_0)
             @(NSFeatureUnsupportedError) :
                 @"Feature unsupported error.",

             @(NSXPCConnectionInterrupted) :
                 @"The XPC connection was interrupted.",

             @(NSXPCConnectionInvalid) :
                 @"The XPC connection was invalid.",

             @(NSXPCConnectionReplyInvalid) :
                 @"The XPC connection reply was invalid.",

             @(NSXPCConnectionErrorMinimum) :
                 @"The XPC connection minimum error.",

             @(NSXPCConnectionErrorMaximum) :
                 @"The XPC connection maximum error.",
#endif
#if defined(__IPHONE_8_0) || defined(__MAC_10_9)
             @(NSUbiquitousFileUnavailableError) :
                 @"The item has not been uploaded to iCloud by another device yet.",

             @(NSUbiquitousFileNotUploadedDueToQuotaError) :
                 @"The item could not be uploaded to iCloud because it would make the account go over its quota.",

             @(NSUbiquitousFileUbiquityServerNotAvailable) :
                 @"Connecting to the iCloud servers failed.",
#endif
             @(NSExecutableNotLoadableError) :
                 @"Executable is of a type that is not loadable in the current process.",

             @(NSExecutableArchitectureMismatchError) :
                 @"Executable does not provide an architecture compatible with the current process.",

             @(NSExecutableRuntimeMismatchError) :
                 @"Executable has Objective C runtime information incompatible with the current process.",
             
             @(NSExecutableLoadError) :
                 @"Executable cannot be loaded for some other reason, such as a problem with a library it depends on.",
             
             @(NSExecutableLinkError) :
                 @"Executable fails due to linking issues."
            };
}

+ (NSDictionary *)_friendlyCoreDataErrorsDescriptions
{
    return @{
             @(NSManagedObjectValidationError) :
                 @"Generic validation error.",

             @(NSValidationMultipleErrorsError) :
                 @"Multiple validation errors.",

             @(NSValidationMissingMandatoryPropertyError) :
                 @"Non-optional property with a nil value.",

             @(NSValidationRelationshipLacksMinimumCountError) :
                 @"To-many relationship with too few destination objects.",

             @(NSValidationRelationshipExceedsMaximumCountError) :
                 @"Bounded to-many relationship with too many destination objects.",

             @(NSValidationRelationshipDeniedDeleteError) :
                 @"Some relationship with delete rule NSDeleteRuleDeny is non-empty.",

             @(NSValidationNumberTooLargeError) :
                 @"Some numerical value is too large.",

             @(NSValidationNumberTooSmallError) :
                 @"Some numerical value is too small.",

             @(NSValidationDateTooLateError) :
                 @"Some date value is too late.",

             @(NSValidationDateTooSoonError) :
                 @"Some date value is too soon.",

             @(NSValidationInvalidDateError) :
                 @"Some date value fails to match date pattern.",

             @(NSValidationStringTooLongError) :
                 @"Some string value is too long.",

             @(NSValidationStringTooShortError) :
                 @"Some string value is too short.",

             @(NSValidationStringPatternMatchingError) :
                 @"Some string value fails to match some pattern.",

             @(NSManagedObjectContextLockingError) :
                 @"Unable to acquire a lock in a managed object context.",

             @(NSPersistentStoreCoordinatorLockingError) :
                 @"Unable to acquire a lock in a persistent store.",

             @(NSManagedObjectReferentialIntegrityError) :
                 @"Attempting to fire a fault pointing to an object that does not exist.",

             @(NSManagedObjectExternalRelationshipError) :
                 @"An object being saved has a relationship containing an object from another store.",

             @(NSManagedObjectMergeError) :
                 @"Merge policy failed, CoreData is unable to complete merging.",

             @(NSPersistentStoreInvalidTypeError) :
                 @"Unknown persistent store type, format or version.",

             @(NSPersistentStoreTypeMismatchError) :
                 @"A store is accessed that does not match the specified type.",

             @(NSPersistentStoreIncompatibleSchemaError) :
                 @"Persistent store returned a database incompatible schema error for a save operation.",

             @(NSPersistentStoreSaveError) :
                 @"Persistent store returned an error for a save operation.",

             @(NSPersistentStoreIncompleteSaveError) :
                 @"One or more of the stores returned an error during a save operations.",

             @(NSPersistentStoreSaveConflictsError) :
                 @"Unresolved merge conflict was encountered during a save.",

             @(NSPersistentStoreOperationError) :
                 @"Persistent store operation failed.",

             @(NSPersistentStoreOpenError) :
                 @"An error occurred while attempting to open a persistent store.",

             @(NSPersistentStoreTimeoutError) :
                 @"CoreData failed to connect to a persistent store within the time specified by NSPersistentStoreTimeoutOption.",

             @(NSPersistentStoreUnsupportedRequestTypeError) :
                 @"An NSPersistentStore subclass was passed a request (an instance of NSPersistentStoreRequest) that it did not understand.",

             @(NSPersistentStoreIncompatibleVersionHashError) :
                 @"Entity version hashes in the store are incompatible with the current managed object model.",

             @(NSMigrationError) :
                 @"General migration error.",

             @(NSMigrationCancelledError) :
                 @"Migration failed due to manual cancellation.",

             @(NSMigrationMissingSourceModelError) :
                 @"Migration failed due to a missing source data model.",

             @(NSMigrationMissingMappingModelError) :
                 @"Migration failed due to a missing mapping model.",

             @(NSMigrationManagerSourceStoreError) :
                 @"Migration failed due to a problem with the source data store.",

             @(NSMigrationManagerDestinationStoreError) :
                 @"Migration failed due to a problem with the destination data store.",

             @(NSEntityMigrationPolicyError) :
                 @"Migration failed during processing of an entity migration policy.",
             
             @(NSInferredMappingModelError) :
                 @"Problem with the creation of an inferred mapping model.",
             
             @(NSExternalRecordImportError) :
                 @"General error encountered while importing external records.",
             
             @(NSCoreDataError) :
                 @"General CoreData error.",
             
             @(NSSQLiteError) :
                 @"General SQLite error."
            };
}

+ (NSDictionary *)_friendlyCommonNetworkErrorDescriptions
{
    return @{
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
             @(kCFURLErrorBackgroundSessionInUseByAnotherProcess) :
                 @"The background session in use by another process.",

             @(kCFURLErrorBackgroundSessionWasDisconnected) :
                 @"The background session was disconnected.",
#endif
             @(kCFURLErrorCancelled) :
                 @"The connection was cancelled.",

             @(kCFURLErrorBadURL) :
                 @"The connection failed due to a malformed URL.",

             @(kCFURLErrorTimedOut) :
                 @"The connection timed out.",

             @(kCFURLErrorUnsupportedURL) :
                 @"The connection failed due to an unsupported URL scheme.",

             @(kCFURLErrorCannotFindHost) :
                 @"The connection failed because the host could not be found.",

             @(kCFURLErrorCannotConnectToHost) :
                 @"The connection failed because a connection cannot be made to the host.",

             @(kCFURLErrorNetworkConnectionLost) :
                 @"The connection failed because the network connection was lost.",

             @(kCFURLErrorDNSLookupFailed) :
                 @"The connection failed because the DNS lookup failed.",

             @(kCFURLErrorHTTPTooManyRedirects) :
                 @"The HTTP connection failed due to too many redirects.",

             @(kCFURLErrorResourceUnavailable) :
                 @"The connection’s resource is unavailable.",

             @(kCFURLErrorNotConnectedToInternet) :
                 @"The connection failed because the device is not connected to the internet.",

             @(kCFURLErrorRedirectToNonExistentLocation) :
                 @"The connection was redirected to a nonexistent location.",

             @(kCFURLErrorBadServerResponse) :
                 @"The connection received an invalid server response.",

             @(kCFURLErrorUserCancelledAuthentication) :
                 @"The connection failed because the user cancelled required authentication.",

             @(kCFURLErrorUserAuthenticationRequired) :
                 @"The connection failed because authentication is required.",

             @(kCFURLErrorZeroByteResource) :
                 @"The resource retrieved by the connection is zero bytes.",

             @(kCFURLErrorCannotDecodeRawData) :
                 @"The connection cannot decode data encoded with a known content encoding.",

             @(kCFURLErrorCannotDecodeContentData) :
                 @"The connection cannot decode data encoded with an unknown content encoding.",

             @(kCFURLErrorCannotParseResponse) :
                 @"The connection cannot parse the server’s response.",

             @(kCFURLErrorInternationalRoamingOff) :
                 @"The connection failed because international roaming is disabled on the device.",

             @(kCFURLErrorCallIsActive) :
                 @"The connection failed because a call is active.",

             @(kCFURLErrorDataNotAllowed) :
                 @"The connection failed because data use is currently not allowed on the device.",

             @(kCFURLErrorRequestBodyStreamExhausted) :
                 @"The connection failed because its request’s body stream was exhausted.",

             @(kCFURLErrorFileDoesNotExist) :
                 @"The file operation failed because the file does not exist.",

             @(kCFURLErrorFileIsDirectory) :
                 @"The file operation failed because the file is a directory.",

             @(kCFURLErrorNoPermissionsToReadFile) :
                 @"The file operation failed because it does not have permission to read the file.",

             @(kCFURLErrorDataLengthExceedsMaximum) :
                 @"The file operation failed because the file is too large.",

             @(kCFURLErrorSecureConnectionFailed) :
                 @"The secure connection failed for an unknown reason.",

             @(kCFURLErrorServerCertificateHasBadDate) :
                 @"The secure connection failed because the server’s certificate has an invalid date.",

             @(kCFURLErrorServerCertificateUntrusted) :
                 @"The secure connection failed because the server’s certificate is not trusted.",

             @(kCFURLErrorServerCertificateHasUnknownRoot) :
                 @"The secure connection failed because the server’s certificate has an unknown root.",

             @(kCFURLErrorServerCertificateNotYetValid) :
                 @"The secure connection failed because the server’s certificate is not yet valid.",

             @(kCFURLErrorClientCertificateRejected) :
                 @"The secure connection failed because the client’s certificate was rejected.",

             @(kCFURLErrorClientCertificateRequired) :
                 @"The secure connection failed because the server requires a client certificate.",

             @(kCFURLErrorCannotLoadFromNetwork) :
                 @"The connection failed because it is being required to return a cached resource, but one is not available.",

             @(kCFURLErrorCannotCreateFile) :
                 @"The file cannot be created.",

             @(kCFURLErrorCannotOpenFile) :
                 @"The file cannot be opened.",

             @(kCFURLErrorCannotCloseFile) :
                 @"The file cannot be closed.",

             @(kCFURLErrorCannotWriteToFile) :
                 @"The file cannot be written.",
             
             @(kCFURLErrorCannotRemoveFile) :
                 @"The file cannot be removed.",
             
             @(kCFURLErrorCannotMoveFile) :
                 @"The file cannot be moved.",
             
             @(kCFURLErrorDownloadDecodingFailedMidStream) :
                 @"The download failed because decoding of the downloaded data failed mid-stream.",
             
             @(kCFURLErrorDownloadDecodingFailedToComplete) :
                 @"The download failed because decoding of the downloaded data failed to complete."
            };
}

+ (NSDictionary *)_friendlyNSURLErrorDescriptions
{
    return @{
#if defined(__IPHONE_8_0) || defined(__MAC_10_10)
             @(NSURLErrorBackgroundSessionRequiresSharedContainer) :
                 @"The background session requires a shared container.",
#endif
             @(NSURLErrorUnknown) :
                 @"The URL Loading system encountered an error that it cannot interpret."
            };
}

+ (NSDictionary *)_friendlyCoreFoundationNetworkErrorDescriptions
{
    return @{
             @(kCFHostErrorHostNotFound) :
                 @"The DNS lookup failed.",

             @(kCFHostErrorUnknown) :
                 @"An unknown host error occurred.",

             @(kCFSOCKSErrorUnknownClientVersion) :
                 @"The SOCKS server rejected access because it does not support connections with the requested SOCKS version.",

             @(kCFSOCKSErrorUnsupportedServerVersion) :
                 @"The version of SOCKS requested by the server is not supported.",

             @(kCFSOCKS4ErrorRequestFailed) :
                 @"Request rejected by the server or request failed.",

             @(kCFSOCKS4ErrorIdentdFailed) :
                 @"Request rejected by the server because it could not connect to the identd daemon on the client.",

             @(kCFSOCKS4ErrorIdConflict) :
                 @"Request rejected by the server because the client program and the identd daemon reported different user IDs.",

             @(kCFSOCKS4ErrorUnknownStatusCode) :
                 @"The status code returned by the server is unknown.",

             @(kCFSOCKS5ErrorBadState) :
                 @"The stream is not in a state that allows the requested operation.",

             @(kCFSOCKS5ErrorBadResponseAddr) :
                 @"The address type returned is not supported",

             @(kCFSOCKS5ErrorBadCredentials) :
                 @"The SOCKS server refused the client connection because of bad login credentials.",

             @(kCFSOCKS5ErrorUnsupportedNegotiationMethod) :
                 @"The requested method is not supported.",

             @(kCFSOCKS5ErrorNoAcceptableMethod) :
                 @"The client and server could not find a mutually agreeable authentication method.",

             @(kCFFTPErrorUnexpectedStatusCode) :
                 @"The server returned an unexpected status code.",

             @(kCFErrorHTTPAuthenticationTypeUnsupported) :
                 @"The client and server could not agree on a supported authentication type.",

             @(kCFErrorHTTPBadCredentials) :
                 @"The credentials provided for an authenticated connection were rejected by the server.",

             @(kCFErrorHTTPConnectionLost) :
                 @"The connection to the server was dropped.",

             @(kCFErrorHTTPParseFailure) :
                 @"The HTTP server response could not be parsed.",

             @(kCFErrorHTTPRedirectionLoopDetected) :
                 @"Too many HTTP redirects occurred before reaching a page that did not redirect the client to another page.",

             @(kCFErrorHTTPBadURL) :
                 @"The requested URL could not be retrieved.",

             @(kCFErrorHTTPProxyConnectionFailure) :
                 @"A connection could not be established to the HTTP proxy.",

             @(kCFErrorHTTPBadProxyCredentials) :
                 @"The authentication credentials provided for logging into the proxy were rejected.",

             @(kCFErrorPACFileError) :
                 @"An error occurred with the proxy autoconfiguration file.",

             @(kCFErrorPACFileAuth) :
                 @"The authentication credentials provided by the proxy autoconfiguration file were rejected.",

             @(kCFErrorHTTPSProxyConnectionFailure) :
                 @"A connection could not be established to the HTTPS proxy.",

             @(kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod) :
                 @"The HTTPS proxy returned an unexpected status code, such as a 3xx redirect.",

             @(kCFURLErrorUnknown) :
                 @"An unknown error occurred.",

             @(kCFHTTPCookieCannotParseCookieFile) :
                 @"The cookie file cannot be parsed.",

             @(kCFNetServiceErrorUnknown) :
                 @"An unknown error occurred.",

             @(kCFNetServiceErrorCollision) :
                 @"An attempt was made to use a name that is already in use.",

             @(kCFNetServiceErrorInProgress) :
                 @"A new search could not be started because a search is already in progress.",

             @(kCFNetServiceErrorBadArgument) :
                 @"A required argument was not provided or was not valid.",

             @(kCFNetServiceErrorCancel) :
                 @"The search or service was cancelled.",

             @(kCFNetServiceErrorInvalid) :
                 @"Invalid data was passed to a CFNetServices function.",

             @(kCFNetServiceErrorTimeout) :
                 @"A search failed because it timed out.",

             @(kCFNetServiceErrorDNSServiceFailure) :
                 @"DNS service discovery returned an error."
            };
}

+ (NSDictionary *)_friendlySQLiteErrorDescriptions
{
    return @{
             @(SQLITE_ERROR) :
                 @"SQL error or missing database.",
             @(SQLITE_INTERNAL) :
                 @"Internal logic error in SQLite.",
             @(SQLITE_PERM) :
                 @"Access permission denied.",
             @(SQLITE_ABORT) :
                 @"Callback routine requested an abort.",
             @(SQLITE_BUSY) :
                 @"The database file is locked.",
             @(SQLITE_LOCKED) :
                 @"A table in the database is locked.",
             @(SQLITE_NOMEM) :
                 @"A malloc() failed.",
             @(SQLITE_READONLY) :
                 @"Attempt to write a readonly database.",
             @(SQLITE_INTERRUPT) :
                 @"Operation terminated by sqlite3_interrupt().",
             @(SQLITE_IOERR) :
                 @"Some kind of disk I/O error occurred.",
             @(SQLITE_CORRUPT) :
                 @"The database disk image is malformed.",
             @(SQLITE_NOTFOUND) :
                 @"Unknown opcode in sqlite3_file_control().",
             @(SQLITE_FULL) :
                 @"Insertion failed because database is full.",
             @(SQLITE_CANTOPEN) :
                 @"Unable to open the database file.",
             @(SQLITE_PROTOCOL) :
                 @"Database lock protocol error.",
             @(SQLITE_EMPTY) :
                 @"Database is empty.",
             @(SQLITE_SCHEMA) :
                 @"The database schema changed.",
             @(SQLITE_TOOBIG) :
                 @"String or BLOB exceeds size limit.",
             @(SQLITE_CONSTRAINT) :
                 @"Abort due to constraint violation.",
             @(SQLITE_MISMATCH) :
                 @"Data type mismatch.",
             @(SQLITE_MISUSE) :
                 @"Library used incorrectly.",
             @(SQLITE_NOLFS) :
                 @"Uses OS features not supported on host.",
             @(SQLITE_AUTH) :
                 @"Authorization denied.",
             @(SQLITE_FORMAT) :
                 @"Auxiliary database format error.",
             @(SQLITE_RANGE) :
                 @"2nd parameter to sqlite3_bind out of range.",
             @(SQLITE_NOTADB) :
                 @"File opened that is not a database file.",
             @(SQLITE_ROW) :
                 @"sqlite3_step() has another row ready.",
             @(SQLITE_DONE) :
                 @"sqlite3_step() has finished executing."
            };
}

+ (NSDictionary *)_friendlyPrintErrorDescriptions
{
    return @{
             @(UIPrintingNotAvailableError) :
                 @"The device does not support printing.",

             @(UIPrintNoContentError) :
                 @"No print formatter, page renderer, printing item or printing items was assigned for printing.",

             @(UIPrintUnknownImageFormatError) :
                 @"An image is in a format not recognized by UIKit for printing.",

             @(UIPrintJobFailedError) :
                 @"An internal error occurred with the print job."
            };
}

+ (NSDictionary *)_friendlyPOSIXErrorDescriptions
{
    return @{
             @(EPERM) :
                 @"Operation not permitted.",
             @(ENOENT) :
                 @"No such file or directory.",
             @(ESRCH) :
                 @"No such process.",
             @(EINTR) :
                 @"Interrupted system call.",
             @(EIO) :
                 @"Input/output error.",
             @(ENXIO) :
                 @"Device not configured.",
             @(E2BIG) :
                 @"Argument list too long.",
             @(ENOEXEC) :
                 @"Exec format error.",
             @(EBADF) :
                 @"Bad file descriptor.",
             @(ECHILD) :
                 @"No child processes.",
             @(EDEADLK) :
                 @"Resource deadlock avoided.",
             @(ENOMEM) :
                 @"Cannot allocate memory.",
             @(EACCES) :
                 @"Permission denied.",
             @(EFAULT) :
                 @"Bad address.",
             @(ENOTBLK) :
                 @"Block device required.",
             @(EBUSY) :
                 @"Device or resource is busy.",
             @(EEXIST) :
                 @"File exists.",
             @(EXDEV) :
                 @"Cross-device link.",
             @(ENODEV) :
                 @"Operation not supported by device.",
             @(ENOTDIR) :
                 @"Not a directory.",
             @(EISDIR) :
                 @"Is a directory.",
             @(EINVAL) :
                 @"Invalid argument.",
             @(ENFILE) :
                 @"Too many open files in system.",
             @(EMFILE) :
                 @"Too many open files.",
             @(ENOTTY) :
                 @"Inappropriate ioctl for device.",
             @(ETXTBSY) :
                 @"Text file busy.",
             @(EFBIG) :
                 @"File too large.",
             @(ENOSPC) :
                 @"No space left on the device.",
             @(ESPIPE) :
                 @"Illegal seek.",
             @(EROFS) :
                 @"Read-only file system.",
             @(EMLINK) :
                 @"Too many links.",
             @(EPIPE) :
                 @"Broken pipe.",
             @(EDOM) :
                 @"Numerical argument out of domain.",
             @(ERANGE) :
                 @"Result too large.",
             @(EAGAIN) :
                 @"Resource temporarily unavailable.",
             @(EINPROGRESS) :
                 @"Operation now in progress.",
             @(EALREADY) :
                 @"Operation already in progress.",
             @(ENOTSOCK) :
                 @"Socket operation on non-socket.",
             @(EDESTADDRREQ) :
                 @"Destination address required.",
             @(EMSGSIZE) :
                 @"Message too long.",
             @(EPROTOTYPE) :
                 @"Protocol wrong type for socket.",
             @(ENOPROTOOPT) :
                 @"Protocol not available.",
             @(EPROTONOSUPPORT) :
                 @"Protocol not supported.",
             @(ESOCKTNOSUPPORT) :
                 @"Socket type not supported.",
             @(ENOTSUP) :
                 @"Operation not supported.",
             @(EPFNOSUPPORT) :
                 @"Protocol family not supported.",
             @(EAFNOSUPPORT) :
                 @"Address family not supported by protocol family.",
             @(EADDRINUSE) :
                 @"Address already in use.",
             @(EADDRNOTAVAIL) :
                 @"Can't assign requested address.",
             @(ENETDOWN) :
                 @"Network is down.",
             @(ENETUNREACH) :
                 @"Network is unreachable.",
             @(ENETRESET) :
                 @"Network dropped connection on reset.",
             @(ECONNABORTED) :
                 @"Software caused connection abort.",
             @(ECONNRESET) :
                 @"Connection reset by peer.",
             @(ENOBUFS) :
                 @"No buffer space available.",
             @(EISCONN) :
                 @"Socket is already connected.",
             @(ENOTCONN) :
                 @"Socket is not connected.",
             @(ESHUTDOWN) :
                 @"Can't send after socket shutdown.",
             @(ETOOMANYREFS) :
                 @"Too many references, can't splice.",
             @(ETIMEDOUT) :
                 @"Operation timed out.",
             @(ECONNREFUSED) :
                 @"Connection refused.",
             @(ELOOP) :
                 @"Too many levels of symbolic links.",
             @(ENAMETOOLONG) :
                 @"File name too long.",
             @(EHOSTDOWN) :
                 @"Host is down.",
             @(EHOSTUNREACH) :
                 @"No route to host.",
             @(ENOTEMPTY) :
                 @"Directory not empty.",
             @(EPROCLIM) :
                 @"Too many processes.",
             @(EUSERS) :
                 @"Too many users.",
             @(EDQUOT) :
                 @"Disc quota exceeded.",
             @(ESTALE) :
                 @"Stale NFS file handle.",
             @(EREMOTE) :
                 @"Too many levels of remote in path.",
             @(EBADRPC) :
                 @"RPC struct is bad.",
             @(ERPCMISMATCH) :
                 @"RPC version wrong.",
             @(EPROGUNAVAIL) :
                 @"RPC prog. not avail.",
             @(EPROGMISMATCH) :
                 @"Program version wrong.",
             @(EPROCUNAVAIL) :
                 @"Bad procedure for program.",
             @(ENOLCK) :
                 @"No locks available.",
             @(ENOSYS) :
                 @"Function not implemented.",
             @(EFTYPE) :
                 @"Inappropriate file type or format.",
             @(EAUTH) :
                 @"Authentication error",
             @(ENEEDAUTH) :
                 @"Need authenticator.",
             @(EPWROFF) :
                 @"Device power is off.",
             @(EDEVERR) :
                 @"Device error, e.g. paper out.",
             @(EOVERFLOW) :
                 @"Value too large to be stored in data type.",
             @(EBADEXEC) :
                 @"Bad executable.",
             @(EBADARCH) :
                 @"Bad CPU type in executable.",
             @(ESHLIBVERS) :
                 @"Shared library version mismatch.",
             @(EBADMACHO) :
                 @"Malformed Macho file.",
             @(ECANCELED) :
                 @"Operation canceled.",
             @(EIDRM) :
                 @"Identifier removed.",
             @(ENOMSG) :
                 @"No message of desired type.",
             @(EILSEQ) :
                 @"Illegal byte sequence.",
             @(ENOATTR) :
                 @"Attribute not found.",
             @(EBADMSG) :
                 @"Bad message.",
             @(EMULTIHOP) :
                 @"Reserved.",
             @(ENODATA) :
                 @"No message available on STREAM.",
             @(ENOLINK) :
                 @"Reserved.",
             @(ENOSR) :
                 @"No STREAM resources.",
             @(ENOSTR) :
                 @"Not a STREAM.",
             @(EPROTO) :
                 @"Protocol error.",
             @(ETIME) :
                 @"STREAM ioctl timeout.",
             @(EOPNOTSUPP) :
                 @"Operation not supported on socket.",
             @(ENOPOLICY) :
                 @"No such policy registered.",
             @(ENOTRECOVERABLE) :
                 @"State not recoverable.",
             @(EOWNERDEAD) :
                 @"Previous owner died.",
             @(EQFULL) :
                 @"Interface output queue is full."
            };
}

+ (NSDictionary *)_friendlyMachErrorDescriptions
{
    return @{
             @KERN_INVALID_ADDRESS :
                 @"The address is not currently valid.",

             @(KERN_PROTECTION_FAILURE) :
                 @"The memory is valid, but does not permit the required forms of access.",

             @(KERN_NO_SPACE) :
                 @"The address range specified is already in use, or no address range of the size specified could be found.",

             @(KERN_INVALID_ARGUMENT) :
                 @"The function requested was not applicable to this type of argument, or an argument is invalid.",

             @(KERN_FAILURE) :
                 @"The function could not be performed.",

             @(KERN_RESOURCE_SHORTAGE) :
                 @"A system resource could not be allocated to fulfill this request. This failure may not be permanent.",

             @(KERN_NOT_RECEIVER) :
                 @"The task in question does not hold receive rights for the port argument.",

             @(KERN_NO_ACCESS) :
                 @"Bogus access restriction.",

             @(KERN_MEMORY_FAILURE) :
                 @"During a page fault, the target address refers to a memory object that has been destroyed.",

             @(KERN_MEMORY_ERROR) :
                 @"During a page fault, the memory object indicated that the data could not be returned.",

             @(KERN_ALREADY_IN_SET) :
                 @"The receive right is already a member of the portset.",

             @(KERN_NOT_IN_SET) :
                 @"The receive right is not a member of a port set.",

             @(KERN_NAME_EXISTS) :
                 @"The name already denotes a right in the task.",

             @(KERN_ABORTED) :
                 @"The operation was aborted.",

             @(KERN_INVALID_NAME) :
                 @"The name doesn't denote a right in the task.",

             @(KERN_INVALID_TASK) :
                 @"Target task isn't an active task.",

             @(KERN_INVALID_RIGHT) :
                 @"The name denotes a right, but not an appropriate right.",

             @(KERN_INVALID_VALUE) :
                 @"A blatant range error.",

             @(KERN_UREFS_OVERFLOW) :
                 @"Operation would overflow limit on user-references.",

             @(KERN_INVALID_CAPABILITY) :
                 @"The supplied (port) capability is improper.",

             @(KERN_RIGHT_EXISTS) :
                 @"The task already has send or receive rights for the port under another name.",

             @(KERN_INVALID_HOST) :
                 @"Target host isn't actually a host.",

             @(KERN_MEMORY_PRESENT) :
                 @"An attempt was made to supply \"precious\" data for memory that is already present in a memory object.",

             @(KERN_MEMORY_RESTART_COPY) :
                 @"A strategic copy was attempted of an object upon which a quicker copy is now possible.",

             @(KERN_INVALID_PROCESSOR_SET) :
                 @"An argument applied to assert processor set privilege was not a processor set control port.",

             @(KERN_POLICY_LIMIT) :
                 @"The specified scheduling attributes exceed the thread's limits.",

             @(KERN_INVALID_POLICY) :
                 @"The specified scheduling policy is not currently enabled for the processor set.",

             @(KERN_INVALID_OBJECT) :
                 @"The external memory manager failed to initialize the memory object.",

             @(KERN_ALREADY_WAITING) :
                 @"A thread is attempting to wait for an event for which there is already a waiting thread.",

             @(KERN_DEFAULT_SET) :
                 @"An attempt was made to destroy the default processor set.",

             @(KERN_EXCEPTION_PROTECTED) :
                 @"An attempt was made to fetch an exception port that is protected, or to abort a thread while processing a protected exception.",

             @(KERN_INVALID_LEDGER) :
                 @"A ledger was required but not supplied.",

             @(KERN_INVALID_MEMORY_CONTROL) :
                 @"The port was not a memory cache control port.",

             @(KERN_INVALID_SECURITY) :
                 @"An argument supplied to assert security privilege was not a host security port.",

             @(KERN_NOT_DEPRESSED) :
                 @"thread_depress_abort was called on a thread which was not currently depressed.",

             @(KERN_TERMINATED) :
                 @"Object has been terminated and is no longer available.",

             @(KERN_LOCK_SET_DESTROYED) :
                 @"Lock set has been destroyed and is no longer available.",

             @(KERN_LOCK_UNSTABLE) :
                 @"The thread holding the lock terminated before releasing the lock.",

             @(KERN_LOCK_OWNED) :
                 @"The lock is already owned by another thread.",

             @(KERN_LOCK_OWNED_SELF) :
                 @"The lock is already owned by the calling thread.",

             @(KERN_SEMAPHORE_DESTROYED) :
                 @"Semaphore has been destroyed and is no longer available.",
             
             @(KERN_RPC_SERVER_TERMINATED) :
                 @"Return from RPC indicating the target server was terminated before it successfully replied.",
             
             @(KERN_RPC_TERMINATE_ORPHAN) :
                 @"Terminate an orphaned activation.",
             
             @(KERN_RPC_CONTINUE_ORPHAN) :
                 @"Allow an orphaned activation to continue executing.",
             
             @(KERN_NOT_SUPPORTED) :
                 @"Empty thread activation.",
             
             @(KERN_NODE_DOWN) :
                 @"Remote node down or inaccessible.",
             
             @(KERN_NOT_WAITING) :
                 @"A signalled thread was not actually waiting.",
             
             @(KERN_OPERATION_TIMED_OUT) :
                 @"Some thread-oriented operation timed out.",
             
             @(KERN_CODESIGN_ERROR) :
                 @"During a page fault, indicates that the page was rejected as a result of a signature check.",
#if defined(__MAC_10_10)
             @(KERN_POLICY_STATIC) :
                 @"The requested property cannot be changed at this time."
#endif
            };
}

SYNTHESIZE_STATIC_PROPERTY(NSDictionary *, friendlyErrorDescription,
{
    return @{
          NSCocoaErrorDomain :
              [[self.class._friendlyFoundationErrorsDescriptions mergeWith:
                self.class._friendlyAppKitErrorsDescriptions] mergeWith:
               self.class._friendlyCoreDataErrorsDescriptions],

          NSURLErrorDomain :
              [self.class._friendlyCommonNetworkErrorDescriptions mergeWith:
               self.class._friendlyNSURLErrorDescriptions],

          (__bridge NSString *)
          kCFErrorDomainCFNetwork :
              [self.class._friendlyCommonNetworkErrorDescriptions mergeWith:
               self.class._friendlyCoreFoundationNetworkErrorDescriptions],

          NSSQLiteErrorDomain :
              self.class._friendlySQLiteErrorDescriptions,

          UIPrintErrorDomain :
              self.class._friendlyPrintErrorDescriptions,

          NSPOSIXErrorDomain :
              self.class._friendlyPOSIXErrorDescriptions,
          
          NSMachErrorDomain :
              self.class._friendlyMachErrorDescriptions
        }.copy;
})

+ (NSString *)friendlyDescriptionWithDomain:(NSString *)domain andCode:(NSInteger)code
{
    return [self.class.friendlyErrorDescription[domain][@(code)] copy];
}

- (NSString *)friendlyLocalizedDescription
{
    NSString *friendlyDescription = [self.class friendlyDescriptionWithDomain:self.domain andCode:self.code];

    return friendlyDescription ? NSLocalizedString(friendlyDescription, nil) : self.localizedDescription;
}

+ (instancetype)friendlyErrorWithDomain:(NSString *)domain andCode:(NSInteger)code
{
    NSString *friendlyDescription = [self.class friendlyDescriptionWithDomain:domain andCode:code];

    return [self.class errorWithDomain:domain
                                  code:code
                              userInfo:friendlyDescription ?
                                        @{
                                            NSLocalizedDescriptionKey :
                                                NSLocalizedString(friendlyDescription, nil)
                                        } : nil];
}

@end
