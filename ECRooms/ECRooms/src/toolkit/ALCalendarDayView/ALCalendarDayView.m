#import "ALCalendarDayView.h"


@interface ALCalendarDayView ()


@property(nonatomic, strong) ALCalendarDayEventsView *eventsView;
@end


@implementation ALCalendarDayView {
@private
    UIScrollView *_scrollView;
}


@synthesize scrollView = _scrollView;


- (id) initWithFrame: (CGRect) frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame: frame];
        self.scrollView.backgroundColor = [UIColor colorWithRed: (242.0 / 255.0) green: (242.0 / 255.0) blue: (242.0 / 255.0) alpha: 1.0];
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, 1078);
        self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.directionalLockEnabled = YES;
        [self addSubview: self.scrollView];

        self.eventsView = [[ALCalendarDayEventsView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, 1078)];
        self.eventsView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self.scrollView addSubview: self.eventsView];
    }
    return self;
}


- (void) setBackgroundColor: (UIColor *) backgroundColor {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super setBackgroundColor: backgroundColor];
    self.scrollView.backgroundColor = backgroundColor;
    self.eventsView.backgroundColor = backgroundColor;
}

@end