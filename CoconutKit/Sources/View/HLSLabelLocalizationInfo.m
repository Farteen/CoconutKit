//
//  HLSLabelLocalizationInfo.m
//  CoconutKit
//
//  Created by Samuel Défago on 12.01.12.
//  Copyright (c) 2012 Hortis. All rights reserved.
//

#import "HLSLabelLocalizationInfo.h"

#import "HLSAssert.h"
#import "HLSLogger.h"
#import "NSArray+HLSExtensions.h"

static NSString * const kMissingLocalizedString = @"UILabel_HLSDynamicLocalization_missing";

static NSString *stringForLabelRepresentation(HLSLabelRepresentation representation);

@interface HLSLabelLocalizationInfo ()

@property (nonatomic, retain) NSString *localizationKey;
@property (nonatomic, retain) NSString *tableName;
@property (nonatomic, retain) NSString *bundleName;
@property (nonatomic, assign) HLSLabelRepresentation representation;

- (void)parseText:(NSString *)text;

@end

@implementation HLSLabelLocalizationInfo

#pragma mark Object creation and destruction

- (id)initWithText:(NSString *)text tableName:(NSString *)tableName bundleName:(NSString *)bundleName
{
    if ((self = [super init])) {
        [self parseText:text];
        
        self.tableName = tableName;
        self.bundleName = bundleName;
    }
    return self;
}

- (id)init
{
    HLSForbiddenInheritedMethod();
    return nil;
}

- (void)dealloc
{
    self.localizationKey = nil;
    self.tableName = nil;
    self.bundleName = nil;
    
    [super dealloc];
}

#pragma mark Accessors and mutators

@synthesize localizationKey = m_localizationKey;

@synthesize tableName = m_tableName;

@synthesize representation = m_representation;

@synthesize locked = m_locked;

#pragma mark Parsing text

- (void)parseText:(NSString *)text
{
    static NSString * const kNormalLeadingPrefix = @"LS/";
    static NSString * const kUppercaseLeadingPrefix = @"ULS/";
    static NSString * const kLowercaseLeadingPrefix = @"LLS/";
    static NSString * const kCapitalizedLeadingPrefix = @"CLS/";
    
    // Check prefix
    NSString *prefix = nil;
    if ([text hasPrefix:kNormalLeadingPrefix]) {
        self.representation = HLSLabelRepresentationNormal;
        prefix = kNormalLeadingPrefix;
    }
    else if ([text hasPrefix:kUppercaseLeadingPrefix]) {
        self.representation = HLSLabelRepresentationUppercase;
        prefix = kUppercaseLeadingPrefix;
    }
    else if ([text hasPrefix:kLowercaseLeadingPrefix]) {
        self.representation = HLSLabelRepresentationLowercase;
        prefix = kLowercaseLeadingPrefix;
    }
    else if ([text hasPrefix:kCapitalizedLeadingPrefix]) {
        self.representation = HLSLabelRepresentationCapitalized;
        prefix = kCapitalizedLeadingPrefix;
    }
    else {
        // If no leading prefix, we are done
        return;
    }
    
    // Extract localization key
    self.localizationKey = [text stringByReplacingCharactersInRange:NSMakeRange(0, [prefix length]) withString:@""];
}

#pragma mark Localizing

- (BOOL)isLocalized
{
    return self.localizationKey != nil;
}

- (BOOL)isIncomplete
{
    // Missing localization key
    if ([self.localizationKey length] == 0) {
        return YES;
    }
    
    // Missing translation
    // TODO: Fetch bundle from its name
    NSString *text = [[NSBundle mainBundle] localizedStringForKey:self.localizationKey
                                                            value:kMissingLocalizedString
                                                            table:self.tableName];
    if ([text isEqualToString:kMissingLocalizedString]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)localizedText
{    
    if (! self.localizationKey) {
        return nil;
    }
    
    // Missing localization key. Return some label to make it clear when the label is displayed on screenyy
    if ([self.localizationKey length] == 0) {
        return @"(no key)";
    }
    
    // We use an explicit constant string for missing localizations since otherwise the localization key itself would 
    // be returned by the localizedStringForKey:value:table method
    NSString *text = [[NSBundle mainBundle] localizedStringForKey:self.localizationKey
                                                            value:kMissingLocalizedString
                                                            table:self.tableName];
    
    // Use the localization key as text if missing
    if ([text isEqualToString:kMissingLocalizedString]) {
        text = self.localizationKey;
    }
    
    // Formatting
    switch (self.representation) {
        case HLSLabelRepresentationUppercase: {
            text = [text uppercaseString];
            break;
        }
            
        case HLSLabelRepresentationLowercase: {
            text = [text lowercaseString];
            break;
        }
            
        case HLSLabelRepresentationCapitalized: {
            text = [text capitalizedString];
            break;
        }
            
        default: {
            break;
        }
    }
    
    return text;
}

#pragma mark Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; localizationKey: %@; tableName: %@; bundleName: %@; representation: %@>",
            [self class],
            self,
            self.localizationKey,
            self.tableName,
            self.bundleName,
            stringForLabelRepresentation(self.representation)];
}

@end

#pragma mark Helper functions

static NSString *stringForLabelRepresentation(HLSLabelRepresentation representation)
{
    switch (representation) {
        case HLSLabelRepresentationNormal: {
            return @"normal";
            break;
        }
            
        case HLSLabelRepresentationUppercase: {
            return @"uppercase";
            break;
        }
            
        case HLSLabelRepresentationLowercase: {
            return @"lowercase";
            break;
        }
            
        case HLSLabelRepresentationCapitalized: {
            return @"capitalized";
            break;
        }
            
        default: {
            HLSLoggerError(@"Unknown representation");
            return @"unknown";
            break;
        }
    }
}
