//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "HLSNullability.h"
#import "HLSObjectAnimation.h"

#import <Foundation/Foundation.h>

/**
 * Interface meant to be used by friend classes of HLSObjectAnimation (= classes which must have access to private implementation
 * details)
 */
NS_ASSUME_NONNULL_BEGIN
@interface HLSObjectAnimation (Friend)

/**
 * Return the object animation corresponding to the inverse animation
 */
- (id)reverseObjectAnimation;

@end
NS_ASSUME_NONNULL_END
