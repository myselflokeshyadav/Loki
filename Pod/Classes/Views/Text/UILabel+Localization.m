//
//  UILabel+Localization.m
//
//
//  Created by Vlad Gorbenko on 5/25/15.
//  Copyright (c) 2015 Vlad Gorbenko. All rights reserved.
//

#import "UILabel+Localization.h"

#import "LKManager.h"

#import <objc/runtime.h>

@implementation UILabel (Localization)

#pragma mark - Setters & Getters

- (NSString *)localizationKey {
    return objc_getAssociatedObject(self, @selector(localizationKey));
}

- (void)setLocalizationKey:(NSString *)localizationKey {
    objc_setAssociatedObject(self, @selector(localizationKey), localizationKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupLocalizedTitle];
}

#pragma mark - Localization

- (void)localize{
    if (self.isLocalized) {
        if ([LKManager sharedInstance].currentLanguage.direction != self.controlDirection) {
            self.controlDirection = [LKManager sharedInstance].currentLanguage.direction;
            [self flipAlignment];
        }
        [self setupLocalizedTitle];
    }
}

- (void)setupLocalizedTitle {
    if (self.isLocalized && self.localizationKey) {
        self.text = LocalizedTitle(self.localizationKey);
    }
}

- (void)flipAlignment{
    switch (self.textAlignment){
        case NSTextAlignmentLeft:
            [self setTextAlignment:NSTextAlignmentRight];
            break;
        case NSTextAlignmentRight:
            [self setTextAlignment:NSTextAlignmentLeft];
            break;
        default:
            break;
    }
}

@end
