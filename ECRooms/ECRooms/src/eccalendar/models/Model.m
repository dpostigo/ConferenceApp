//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <EventKit/EventKit.h>
#import "Model.h"
#import "NSDate+Utils.h"


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
            self.currentRoomType = RoomTypeCloud;
        } else {
            self.currentRoomType = (RoomType) [number integerValue];
        }
    }

    return self;
}




- (BOOL) availabilityForRoomType: (RoomType) roomType {

    NSDate *date = [NSDate date];
    NSArray *events = [self eventsForRoom: roomType];

    for (EKEvent *event in events) {

        if ([date isBetweenDate: event.startDate andDate: event.endDate]) {
            return NO;
        }
    }

    return YES;
}


- (NSString *) currentRoomStringIdentifier {
    return [self stringIdentifierForRoomType: self.currentRoomType];
}


- (NSString *) currentRoomSlug {
    return [self slugForRoomType: self.currentRoomType];
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
        return CLOUD_IDENTIFIER;
    } else if (aType == RoomTypeFieldInteractive) {
        return INTERACTIVE_IDENTIFIER;
    } else if (aType == RoomType550Conference) {
        return CONFERENCE_IDENTIFIER;
    }

    return @"No name";
}


- (RoomType) roomTypeForIdentifier: (NSString *) identifier {
    if ([identifier isEqualToString: CLOUD_IDENTIFIER]) {
        return RoomTypeCloud;
    } else if ([identifier isEqualToString: INTERACTIVE_IDENTIFIER]) {
        return RoomTypeFieldInteractive;
    } else if ([identifier isEqualToString: CONFERENCE_IDENTIFIER]) {
        return RoomType550Conference;
    }
    return RoomTypeNotFound;
}


- (NSArray *) eventsForRoom: (RoomType) aType {
    NSString *roomName = [self stringIdentifierForRoomType: aType];
    NSMutableArray *events = [[NSMutableArray alloc] init];
    for (EKEvent *event in self.calendarEvents) {
        if ([event.calendar.title isEqualToString: roomName]) {
            [events addObject: event];
        }
    }
    return events;
}


- (NSArray *) currentCalendarEvents {
    return [self eventsForRoom: self.currentRoomType];
}

@end