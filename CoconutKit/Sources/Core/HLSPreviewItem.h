//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "HLSNullability.h"

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

/**
 * Simple QLPreviewItem implementation. Should be self-explanatory
 */
NS_ASSUME_NONNULL_BEGIN
@interface HLSPreviewItem : NSObject <QLPreviewItem>

- (instancetype)initWithPreviewItemURL:(nullable NSURL *)previewItemURL previewItemTitle:(nullable NSString *)previewItemTitle NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithPreviewItemURL:(nullable NSURL *)previewItemURL;

@end

@interface HLSPreviewItem (Unavailalble)

- (instancetype)init NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END
