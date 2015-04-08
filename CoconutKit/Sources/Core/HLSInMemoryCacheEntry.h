//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "HLSNullability.h"

#import <Foundation/Foundation.h>

/**
 * Private class containing the information of an entry within the cache managed by HLSInMemoryFileManager
 *
 * This additional bookkeeping is required because the cache can cleanup objects when it grows too large. In such
 * cases, the internal file hierarchy dictionary maintained by the file manager needs to be updated to reflect which
 * object has been discarded
 */
NS_ASSUME_NONNULL_BEGIN
@interface HLSInMemoryCacheEntry : NSObject

/**
 * Create a cache entry. The name points at an object contained within the parentItems file dictionary
 */
- (instancetype)initWithParentItems:(NSMutableDictionary *)parentItems
                               name:(NSString *)name
                               data:(NSData *)data NS_DESIGNATED_INITIALIZER;

/**
 * Access entry information
 */
@property (nonatomic, readonly, weak) NSMutableDictionary *parentItems;
@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSData *data;

@property (nonatomic, readonly) NSUInteger cost;

@end

@interface HLSInMemoryCacheEntry (UnavailableMethods)

- (instancetype)init NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END
