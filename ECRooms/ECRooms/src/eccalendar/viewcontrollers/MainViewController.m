//
// Created by dpostigo on 12/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainViewController.h"
#import "ALCalendarDayEventsView.h"
#import "ALCalendarDayView.h"
#import "ALCalendarEvent.h"
#import "CustomTileViewController.h"
#import "GetDataOperation.h"
#import "RoomPlaque.h"
#import "BasicTableCell.h"


@interface MainViewController () <ALCalendarDayEventsViewDataSource, ALCalendarDayEventsViewDelegate> {

    RoomPlaque *roomPlaque;
    IBOutlet UIView *calendarContainer;
    IBOutlet ALCalendarDayView *calendar;
    IBOutlet UIView *roomPlaqueContainer;
    IBOutlet UIView *plaque2;
}


@end


@implementation MainViewController


- (void) loadView {
    [super loadView];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    roomPlaque = [[[NSBundle mainBundle] loadNibNamed: @"Plaque1" owner: self options: nil] objectAtIndex: 0];
    [roomPlaqueContainer addSubview: roomPlaque];

    [plaque2 addSubview: [[[NSBundle mainBundle] loadNibNamed: @"Plaque2" owner: self options: nil] objectAtIndex: 0]];
}


- (void) awakeFromNib {
    [super awakeFromNib];

    NSLog(@"roomPlaque.titleLabel = %@", roomPlaque.titleLabel);
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
    calendarView.eventsView.leftMargin = 95.0;
    calendarView.scrollView.contentSize = CGSizeMake(calendarView.width, calendarView.scrollView.contentSize.height);

    calendarView.scrollView.contentOffset = CGPointMake(0, calendarView.eventsView.height - calendarView.scrollView.height);

    [_queue addOperation: [[GetDataOperation alloc] init]];

    roomPlaque.titleLabel.text = [[_model slugForRoomType: _model.currentRoomType] uppercaseString];
}


- (void) calendarsNotFound {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Elastic Calendars Not Found" message: @"You do not have any calendars associated with the EC meeting spaces." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alertView show];
}
@end
