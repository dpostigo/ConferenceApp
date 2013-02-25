//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface NSDate (Utils)


+ (BOOL) date: (NSDate *) date isBetweenDate: (NSDate *) beginDate andDate: (NSDate *) endDate;
- (BOOL) isBetweenDate: (NSDate *) beginDate andDate: (NSDate *) endDate;

@end