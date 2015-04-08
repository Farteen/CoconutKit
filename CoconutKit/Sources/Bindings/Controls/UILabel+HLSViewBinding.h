//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

#import "UIView+HLSViewBindingImplementation.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Binding support for UILabel:
 *   - binds to NSString model values
 *   - displays the underlying model value, but cannot update it
 *   - does not animate updates
 */
@interface UILabel (HLSViewBindingImplementation) <HLSViewBindingImplementation>
@end
