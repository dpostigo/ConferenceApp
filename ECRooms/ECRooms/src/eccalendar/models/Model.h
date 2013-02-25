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

    NSArray *calendarEvents;
    NSMutableArray *calendars;
    RoomType currentRoomType;

    EKEventStore *eventStore;
}


@property(nonatomic, strong) NSArray *calendarEvents;
@property(nonatomic) RoomType currentRoomType;
@property(nonatomic, strong) NSMutableArray *calendars;
@property(nonatomic, strong) EKEventStore *eventStore;
+ (Model *) sharedModel;
- (BOOL) availabilityForRoomType: (RoomType) aRoomType;
- (NSString *) currentRoomStringIdentifier;
- (NSString *) currentRoomSlug;
- (NSString *) slugForRoomType: (RoomType) aType;
- (NSString *) stringIdentifierForRoomType: (RoomType) aType;
- (RoomType) roomTypeForIdentifier: (NSString *) identifier;
- (NSArray *) currentCalendarEvents;

@end