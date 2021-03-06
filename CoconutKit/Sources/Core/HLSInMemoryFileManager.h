//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "HLSFileManager.h"

#import <Foundation/Foundation.h>

/**
 * A file manager implementation storing data in memory. If the application receives a memory warning, this data
 * cache is automatically cleared
 */
@interface HLSInMemoryFileManager : HLSFileManager <NSCacheDelegate>

/**
 * Size of the data cache, in bytes, above which the cache might be cleaned (refer to the -[NSCache setTotalCostLimit:] 
 * method documentation for more information). When data is added to the cache, its size in bytes is used as cost
 *
 * Default value is 0 (no limit)
 */
@property (nonatomic, assign) NSUInteger byteCostLimit;

@end
