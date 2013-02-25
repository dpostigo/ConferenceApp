//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSDate+Utils.h"


@implementation NSDate (Utils)


+ (BOOL) date: (NSDate *) date isBetweenDate: (NSDate *) beginDate andDate: (NSDate *) endDate {
    if ([date compare: beginDate] == NSOrderedAscending)
        return NO;

    if ([date compare: endDate] == NSOrderedDescending)
        return NO;

    return YES;
}


- (BOOL) isBetweenDate: (NSDate *) beginDate andDate: (NSDate *) endDate {
    if ([self compare: beginDate] == NSOrderedAscending)
        return NO;

    if ([self compare: endDate] == NSOrderedDescending)
        return NO;

    return YES;
}

@end