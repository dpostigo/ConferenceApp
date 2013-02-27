#import <QuartzCore/QuartzCore.h>
#import <EventKit/EventKit.h>
#import "CustomTileViewController.h"
#import "ALCalendarEvent.h"
#import "ALCalendarTileView.h"
#import "Model.h"
#import "NSDate+Utils.h"


@interface CustomTileView : ALCalendarTileView


@property(nonatomic, strong) UIView *leftView;
@property(nonatomic, strong) UIColor *leftViewBackgroundColor;
@end


@implementation CustomTileView


- (id) init {
    self = [super init];
    if (self) {

        self.leftView = [[UIView alloc] initWithFrame: CGRectZero];
        //  [self addSubview: self.leftView];

        //        self.titleLabel.font = [UIFont fontWithName: @"Antartida-Black" size: 12.0];
        self.titleLabel.font = [UIFont fontWithName: @"Antartida-Bold" size: 12.0];
        self.titleLabel.textColor = [UIColor colorWithRed: 1.0 green: 0 blue: 0 alpha: 0.5];
        self.titleLabel.textColor = [UIColor whiteColor];

        self.titleLabel.layer.shadowOpacity = 1.0;
        self.titleLabel.layer.shadowOffset = CGSizeMake(0, 1);
        self.titleLabel.layer.shadowRadius = 1.0;

        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 1.0;
    }
    return self;
}


- (void) layoutSubviews {

    self.backgroundColor = [self.leftViewBackgroundColor colorWithAlphaComponent: 0.3];
    self.layer.borderColor = self.leftViewBackgroundColor.CGColor;

    self.leftView.frame = CGRectMake(0, 0, 10, self.frame.size.height);
    self.leftView.backgroundColor = self.leftViewBackgroundColor;

    self.titleLabel.frame = CGRectMake(10, 5, self.frame.size.width - 30, 15);
    self.titleLabel.layer.shadowColor = [self.leftViewBackgroundColor colorWithAlphaComponent: 0.5].CGColor;
    //    self.titleLabel.shadowOffset = CGSizeZero;



    if (self.leftViewBackgroundColor == [UIColor lightGrayColor]) {
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.layer.shadowOpacity = 0;
        self.titleLabel.layer.shadowRadius = 0;
        self.titleLabel.layer.borderWidth = 0;
        self.titleLabel.font = [UIFont fontWithName: @"Antartida-Black" size: 12.0];
        self.titleLabel.shadowColor = [UIColor clearColor];
    } else {
    }
}

@end


@interface CustomTileViewController () <ALCalendarDayEventsViewDataSource, ALCalendarDayEventsViewDelegate>


@end


@implementation CustomTileViewController {
    ALCalendarDayView *calendarDayView;
}


@synthesize calendarDayView;


- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        calendarDayView = [[ALCalendarDayView alloc] initWithFrame: self.view.bounds];
        calendarDayView.eventsView.amPmFormat = YES;
        calendarDayView.eventsView.dataSource = self;
        calendarDayView.eventsView.delegate = self;

        [self.view addSubview: calendarDayView];
    }

    return self;
}


- (void) viewDidLoad {
    [super viewDidLoad];
}


- (NSArray *) calendarEventsForDate: (NSDate *) date {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];

    NSMutableArray *newEvents = [[NSMutableArray alloc] init];

    for (EKEvent *event in _model.calendarEvents) {
        ALCalendarEvent *displayEvent = [[ALCalendarEvent alloc] init];
        displayEvent.start = event.startDate;
        displayEvent.end = event.endDate;


        displayEvent.title = [NSString stringWithFormat: @"%@ %@", [event.title uppercaseString], event.organizer.name];
        displayEvent.description = event.organizer.name;
        displayEvent.location = event.location;

        if ([event.calendar.title isEqualToString: _model.currentRoomStringIdentifier]) {
            displayEvent.color = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1.0];
        } else {

            displayEvent.color = [UIColor lightGrayColor];
        }
        [newEvents addObject: displayEvent];
    }

    return newEvents;
}


- (ALCalendarTileView *) tileViewForEvent: (ALCalendarEvent *) event {
    CustomTileView *tileView = [[CustomTileView alloc] init];
    tileView.leftViewBackgroundColor = event.color;
    tileView.titleLabel.text = event.title;
    return tileView;
}


- (void) didUpdateCalendarEvents {

    [self.calendarDayView.eventsView reloadData];
}


- (void) currentRoomTypeDidChange {
    [self.calendarDayView.eventsView reloadData];
}

@end

