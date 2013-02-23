//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <EventKit/EventKit.h>
#import "Model.h"


@implementation Model {
}


@synthesize calendarEvents;
@synthesize currentRoomType;
@synthesize calendars;
@synthesize eventStore;


+ (Model *) sharedModel {
    static Model *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}


- (id) init {
    self = [super init];
    if (self) {

        self.calendarEvents = [NSArray array];
        self.calendars = [[NSMutableArray alloc] init];

        NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey: @"currentRoomType"];
        NSLog(@"number = %@", number);

        if (number == nil) {
            NSLog(@"Number is nil.");
            self.currentRoomType = RoomTypeCloud;
        } else {
            self.currentRoomType = (RoomType) [number integerValue];
        }
    }

    return self;
}


- (NSString *) currentRoomStringIdentifier {
    return [self stringIdentifierForRoomType: self.currentRoomType];
}


- (NSString *) slugForRoomType: (RoomType) aType {

    if (aType == RoomTypeCloud) {
        return @"Meeting Cloud 1";
    } else if (aType == RoomTypeFieldInteractive) {
        return @"Meeting Field (Interactive)";
    } else if (aType == RoomType550Conference) {
        return @"Meeting 550 Conference";
    }

    return @"No name";
}


- (NSString *) stringIdentifierForRoomType: (RoomType) aType {
    if (aType == RoomTypeCloud) {
        return @"*Meeting Cloud (Loft)";
    } else if (aType == RoomTypeFieldInteractive) {
        return @"*Meeting Field (Interactive)";
    } else if (aType == RoomType550Conference) {
        return @"*Meeting 550 Conference";
    }

    return @"No name";
}


- (NSArray *) eventsForRoom: (RoomType) aType {
    return nil;
}


- (NSArray *) currentCalendarEvents {

    NSString *roomName = [self stringIdentifierForRoomType: self.currentRoomType];
    NSLog(@"roomName = %@", roomName);

    NSMutableArray *events = [[NSMutableArray alloc] init];
    for (EKEvent *event in self.calendarEvents) {

        NSLog(@"event.calendar.title = %@", event.calendar.title);
        if ([event.calendar.title isEqualToString: roomName]) {
            [events addObject: event];
        }
    }
    return events;

    NSArray *array = [self.calendarEvents filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"SELF.calendar.title == [c] %@", roomName]];

    NSLog(@"array = %@", array);

    return array;
}

@end