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
//        calendar.timeZone = [NSTimeZone timeZoneWithName: @"PST"];


        NSDateComponents *currentDayComponents = [calendar components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate: [NSDate date]];
        // Create the start date components

        NSDateComponents *startOfDayComponents = [[NSDateComponents alloc] init];
        startOfDayComponents.hour = 0;
        startOfDayComponents.minute = 0;
        startOfDayComponents.second = 0;
        startOfDayComponents.day = currentDayComponents.day;
        startOfDayComponents.year = currentDayComponents.year;
        startOfDayComponents.month = currentDayComponents.month;

        NSDate *startOfDay = [calendar dateFromComponents: startOfDayComponents];

        // Create the end date components
        NSDateComponents *endOfDayComponents = [[NSDateComponents alloc] init];
        endOfDayComponents.hour = startOfDayComponents.hour;
        endOfDayComponents.minute = startOfDayComponents.minute;
        endOfDayComponents.second = startOfDayComponents.second;
        endOfDayComponents.day = startOfDayComponents.day + 1;
        endOfDayComponents.year = startOfDayComponents.year;
        endOfDayComponents.month = startOfDayComponents.month;

        NSDate *endOfDay = [calendar dateFromComponents: endOfDayComponents];
        NSPredicate *predicate = [store predicateForEventsWithStartDate: startOfDay endDate: endOfDay calendars: _model.calendars];
        NSArray *events = [store eventsMatchingPredicate: predicate];


        //        NSMutableArray *filteredEvents = [[NSMutableArray alloc] initWithArray: [events filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"allDay == 0"]]];
        NSMutableArray *array = [[NSMutableArray alloc] init];

        for (EKEvent *event in events) {
            [array addObject: event];
        }

        _model.calendarEvents = array;
        [_model notifyDelegates: @selector(didUpdateCalendarEvents) object: nil];
    }];
}

@end