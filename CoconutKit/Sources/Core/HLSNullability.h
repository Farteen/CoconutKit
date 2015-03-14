//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  Licence information is available from the LICENCE file.
//

// Compatibility macros for Xcode version < 6.3
// TODO: Remove when Xcode 6.3 is the official current release. After Xcode 6.3 has been
//       released, we might also be able to remove assertions since the compiler will enforce
//       checks. Maybe this is a bad idea if such checks can be disabled
#if ! __has_feature(nullability)
    #define NS_ASSUME_NONNULL_BEGIN
    #define NS_ASSUME_NONNULL_END
    #define nullable
    #define nonnull
    #define null_unspecified
    #define null_resettable
    #define __nullable
    #define __nonnull
    #define __null_unspecified
#endif
