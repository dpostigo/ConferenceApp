//
// Created by dpostigo on 12/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainViewController.h"
#import "ALCalendarDayEventsView.h"
#import "ALCalendarDayView.h"
#import "ALCalendarEvent.h"
#import "ALCalendarTileView.h"
#import "ALCalendar.h"
#import "ALCalendar.h"
#import "DayViewExampleController.h"
#import "DefaultStylesViewController.h"
#import "CustomTileViewController.h"

//
//@interface CustomTileView : ALCalendarTileView
//
//
//@property(nonatomic, strong) UIView *leftView;
//@property(nonatomic, strong) UIColor *leftViewBackgroundColor;
//
//@end
//
//
//@implementation CustomTileView
//
//
//- (id) init {
//    self = [super init];
//    if (self) {
//        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent: 0.2];
//        self.leftView = [[UIView alloc] initWithFrame: CGRectZero];
//        [self addSubview: self.leftView];
//
//        self.titleLabel.textColor = [UIColor darkGrayColor];
//    }
//    return self;
//}
//
//
//- (void) layoutSubviews {
//    self.leftView.frame = CGRectMake(0, 0, 10, self.frame.size.height);
//    self.leftView.backgroundColor = self.leftViewBackgroundColor;
//
//    self.titleLabel.frame = CGRectMake(20, 0, self.frame.size.width - 30, 15);
//    self.titleLabel.shadowOffset = CGSizeZero;
//}
//
//@end


@interface MainViewController () <ALCalendarDayEventsViewDataSource, ALCalendarDayEventsViewDelegate> {

    IBOutlet UIView *calendarContainer;
    IBOutlet ALCalendarDayView *calendar;
    IBOutlet UIView *plaque1;
    IBOutlet UIView *plaque2;
}


@end


@implementation MainViewController


- (void) loadView {
    [super loadView];
    NSLog(@"%s", __PRETTY_FUNCTION__);

    [plaque1 addSubview: [[[NSBundle mainBundle] loadNibNamed: @"Plaque1" owner: self options: nil] objectAtIndex: 0]];
    [plaque2 addSubview: [[[NSBundle mainBundle] loadNibNamed: @"Plaque2" owner: self options: nil] objectAtIndex: 0]];
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

    calendarView.eventsView.amPmFormat = YES;
    calendarView.backgroundColor = [UIColor clearColor];
    calendarView.eventsView.timeLabelsFont = [UIFont boldSystemFontOfSize: 15.0];
    calendarView.eventsView.leftMargin = 95.0;
    calendarView.scrollView.contentSize = CGSizeMake(calendarView.width, calendarView.scrollView.contentSize.height);
}


- (NSArray *) calendarEventsForDate: (NSDate *) date {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    ALCalendarEvent *sleepEvent = [[ALCalendarEvent alloc] init];
    sleepEvent.start = [dateFormatter dateFromString: @"2012-08-08 03:00"];
    sleepEvent.end = [dateFormatter dateFromString: @"2012-08-08 08:00"];
    sleepEvent.color = [UIColor colorWithRed: 0.1 green: 0.9 blue: 0.1 alpha: 0.6];
    sleepEvent.title = @"Sleep";
    [result addObject: sleepEvent];

    ALCalendarEvent *workEvent = [[ALCalendarEvent alloc] init];
    workEvent.start = [dateFormatter dateFromString: @"2012-08-08 09:00"];
    workEvent.end = [dateFormatter dateFromString: @"2012-08-08 19:00"];
    workEvent.color = [UIColor colorWithRed: 0.1 green: 0.2 blue: 0.9 alpha: 0.6];
    workEvent.title = @"Work";
    workEvent.description = @"Developing day calendar view component. Discussing aTimeLogger UI with designer";
    [result addObject: workEvent];

    ALCalendarEvent *dinnerEvent = [[ALCalendarEvent alloc] init];
    dinnerEvent.start = [dateFormatter dateFromString: @"2012-08-08 13:00"];
    dinnerEvent.end = [dateFormatter dateFromString: @"2012-08-08 14:00"];
    dinnerEvent.color = [UIColor colorWithRed: 0 green: 0.9 blue: 0.1 alpha: 0.6];
    dinnerEvent.title = @"Dinner";
    dinnerEvent.description = @"Some sea food";
    [result addObject: dinnerEvent];

    return result;
}

//
//- (ALCalendarTileView *) tileViewForEvent: (ALCalendarEvent *) event {
//    CustomTileView *tileView = [[CustomTileView alloc] init];
//    tileView.leftViewBackgroundColor = event.color;
//    tileView.titleLabel.text = event.title;
//    return tileView;
//}

@end
