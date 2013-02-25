#import <UIKit/UIKit.h>


@class ALCalendarTileView;
@class ALCalendarEvent;


@protocol ALCalendarDayEventsViewDataSource <NSObject>
- (NSArray *) calendarEventsForDate: (NSDate *) date;
@end


@protocol ALCalendarDayEventsViewDelegate <NSObject>


@optional
- (ALCalendarTileView *) tileViewForEvent: (ALCalendarEvent *) event;
@end


@interface ALCalendarDayEventsView : UIView {

    UIColor *timeLabelsColor;
    UIFont *timeLabelsFont;
}


@property(nonatomic) BOOL amPmFormat;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic) CGFloat leftMargin;
@property(nonatomic) CGFloat rightMargin;
@property(nonatomic) CGFloat topMargin;
@property(nonatomic, weak) id <ALCalendarDayEventsViewDataSource> dataSource;
@property(nonatomic, weak) id <ALCalendarDayEventsViewDelegate> delegate;
@property(nonatomic, strong) UIColor *timeLabelsColor;
@property(nonatomic, strong) UIFont *timeLabelsFont;
@property(nonatomic) float gutterWidth;
@property(nonatomic, strong) UIImageView *indicatorImage;
- (void) reloadData;

@end
