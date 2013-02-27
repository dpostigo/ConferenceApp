//
// Created by dpostigo on 9/20/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "BasicModel.h"
#import "RoomType.h"


@interface Model : BasicModel {

    NSDate *currentDate;
    NSArray *calendarEvents;
    RoomType currentRoomType;
    NSMutableArray *calendars;
    EKEventStore *eventStore;

    EKEvent *currentNewEvent;
}


@property(nonatomic, strong) NSArray *calendarEvents;
@property(nonatomic) RoomType currentRoomType;
@property(nonatomic, strong) NSMutableArray *calendars;
@property(nonatomic, strong) EKEventStore *eventStore;
@property(nonatomic, strong) NSDate *currentDate;
@property(nonatomic, strong) EKEvent *currentNewEvent;


+ (Model *) sharedModel;
- (BOOL) isCaliforniaTime;
- (NSDate *) nextAvailableStartTime;
- (BOOL) availabilityForRoomType: (RoomType) aRoomType;
- (EKCalendar *) currentCalendar;
- (NSString *) currentRoomStringIdentifier;
- (NSString *) currentRoomSlug;
- (NSString *) slugForRoomType: (RoomType) aType;
- (NSString *) stringIdentifierForRoomType: (RoomType) aType;
- (RoomType) roomTypeForIdentifier: (NSString *) identifier;
- (NSArray *) currentCalendarEvents;

@end