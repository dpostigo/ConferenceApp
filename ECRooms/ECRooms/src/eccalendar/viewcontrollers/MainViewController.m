//
// Created by dpostigo on 12/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainViewController.h"
#import "ALCalendarDayEventsView.h"
#import "ALCalendarDayView.h"
#import "CustomTileViewController.h"
#import "GetDataOperation.h"
#import "RoomPlaque.h"
#import "NSDate+Utils.h"
#import "AvailabilityPlaque.h"
#import "SaveEventOperation.h"


@interface MainViewController () {

    RoomPlaque *roomPlaque;
    IBOutlet UIView *roomPlaqueContainer;
    AvailabilityPlaque *availablePlaque;
    IBOutlet UIView *availabilityContainer;

    IBOutlet UIView *calendarContainer;
    IBOutlet ALCalendarDayView *calendar;
}


@end


@implementation MainViewController


- (void) loadView {
    [super loadView];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    roomPlaque = [[[NSBundle mainBundle] loadNibNamed: @"Plaque1" owner: self options: nil] objectAtIndex: 0];
    [roomPlaqueContainer addSubview: roomPlaque];

    availablePlaque = [[[NSBundle mainBundle] loadNibNamed: @"Plaque2" owner: self options: nil] objectAtIndex: 0];
    [availabilityContainer addSubview: availablePlaque];

    NSArray *array = [NSArray arrayWithObjects: CLOUD_IDENTIFIER, INTERACTIVE_IDENTIFIER, CONFERENCE_IDENTIFIER, nil];

    for (UILabel *label in availablePlaque.labels) {

        NSInteger index = [availablePlaque.labels indexOfObject: label];
        NSString *identifier = [array objectAtIndex: index];
        RoomType roomType = [_model roomTypeForIdentifier: identifier];
        label.text = [_model slugForRoomType: roomType];

        BOOL isAvailable = [_model availabilityForRoomType: roomType];
        UIImageView *imageView = [availablePlaque.imageViews objectAtIndex: index];

        if (isAvailable) {
            imageView.image = [UIImage imageNamed: @"available-control.png"];
        } else {

            imageView.image = [UIImage imageNamed: @"in-use-control.png"];
        }
    }
}


- (void) viewDidLoad {
    [super viewDidLoad];

    calendar.eventsView.amPmFormat = YES;
    calendar.eventsView.dataSource = self;
    calendar.eventsView.delegate = self;

    calendarContainer.hidden = NO;

    CustomTileViewController *controller = [[CustomTileViewController alloc] init];
    ALCalendarDayView *calendarView = controller.calendarDayView;
    calendarView.frame = calendarContainer.bounds;
    [calendarContainer addSubview: calendarView];

    calendarView.eventsView.amPmFormat = NO;
    calendarView.backgroundColor = [UIColor clearColor];
    calendarView.eventsView.timeLabelsFont = [UIFont boldSystemFontOfSize: 12.0];
    calendarView.eventsView.timeLabelsFont = [UIFont fontWithName: @"Antartida-Black" size: 12.0];
    calendarView.scrollView.contentSize = CGSizeMake(calendarView.width, calendarView.scrollView.contentSize.height);

    calendarView.scrollView.contentOffset = CGPointMake(0, calendarView.eventsView.height - calendarView.scrollView.height);

    [_queue addOperation: [[GetDataOperation alloc] init]];

    roomPlaque.titleLabel.text = [[_model slugForRoomType: _model.currentRoomType] uppercaseString];

    [availablePlaque.reserveButton addTarget: self action: @selector(handleReserveButton:) forControlEvents: UIControlEventTouchUpInside];

    [self subscribeTextField: availablePlaque.eventTextField];
    [self currentRoomTypeDidChange];
    [self performSelector: @selector(fetchUpdatedInformation) withObject: nil afterDelay: 60.0];
}


- (void) fetchUpdatedInformation {

    _model.currentDate = [[[NSDate date] toGlobalTime] toPST];
    [_queue addOperation: [[GetDataOperation alloc] init]];
}


- (IBAction) handleReserveButton: (id) sender {

    [_queue addOperation: [[SaveEventOperation alloc] init]];
}

#pragma mark Callbacks
- (void) calendarsNotFound {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Elastic Calendars Not Found" message: @"You do not have any calendars associated with the EC meeting spaces." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alertView show];
}


- (void) currentRoomTypeDidChange {

    BOOL isAvailable = [_model availabilityForRoomType: _model.currentRoomType];

    if (isAvailable) {

        if (availablePlaque.isFlippedToFront) {
            [availablePlaque flip];
        }
    } else {

        if (!availablePlaque.isFlippedToFront) {
            [availablePlaque flip];
        }
    }
}

@end
