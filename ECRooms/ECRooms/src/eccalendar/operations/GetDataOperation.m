//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GetDataOperation.h"
#import <EventKit/EventKit.h>


@implementation GetDataOperation {
}


- (void) main {
    [super main];

    if (_model.eventStore == nil) {
        _model.eventStore = [[EKEventStore alloc] init];
    }

    EKEventStore *store = _model.eventStore;

    [store requestAccessToEntityType: EKEntityTypeEvent completion: ^(BOOL granted, NSError *error) {

        NSArray *calendars = [store calendarsForEntityType: EKEntityTypeEvent];
        for (EKCalendar *calendar in calendars) {
            if ([calendar.title isEqualToString: @"*Meeting 550 Conference"] ||
                    [calendar.title isEqualToString: @"*Meeting Cloud (Loft)"] ||
                    [calendar.title isEqualToString: @"*Meeting Field (Interactive)"]) {

                [_model.calendars addObject: calendar];
            }


        }

        if ([_model.calendars count] == 0) {
            [_model notifyDelegates: @selector(calendarsNotFound) object: nil];
        }
        NSCalendar *calendar = [NSCalendar currentCalendar];


        // Create the start date components
        NSDateComponents *startOfDay = [[NSDateComponents alloc] init];
        //        startOfDay.day = -1;
        startOfDay.hour = 0;
        NSDate *oneDayAgo = [calendar dateByAddingComponents: startOfDay toDate: [NSDate date] options: 0];

        // Create the end date components
        NSDateComponents *endOfDay = [[NSDateComponents alloc] init];
        endOfDay.hour = 24;

        NSDate *oneYearFromNow = [calendar dateByAddingComponents: endOfDay toDate: [NSDate date] options: 0];
        NSDate *startDate = [NSDate date];
        NSPredicate *predicate = [store predicateForEventsWithStartDate: oneDayAgo endDate: oneYearFromNow calendars: _model.calendars];
        NSArray *events = [store eventsMatchingPredicate: predicate];
        NSMutableArray *filteredEvents = [[NSMutableArray alloc] initWithArray: [events filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"allDay == 0"]]];
        NSMutableArray *array = [[NSMutableArray alloc] init];

        for (EKEvent *event in filteredEvents) {
            if (![event.location isEqualToString: @""]) {
                [array addObject: event];
            }
        }

        _model.calendarEvents = array;
        [_model notifyDelegates: @selector(didUpdateCalendarEvents) object: nil];
    }];
}

@end