#import <UIKit/UIKit.h>

#import "ALCalendarDayEventsView.h"


@interface ALCalendarDayView : UIView


@property(nonatomic, readonly) ALCalendarDayEventsView *eventsView;
@property(nonatomic, strong) UIScrollView *scrollView;

@end