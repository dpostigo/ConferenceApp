//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import <EventKit/EventKit.h>
#import "AvailabilityPlaque.h"
#import "Model.h"


@implementation AvailabilityPlaque {
    UIButton *currentButton;
    EKEvent *newEvent;
}


@synthesize eventTextField;
@synthesize labels;
@synthesize imageViews;
@synthesize reserveButton;


- (IBAction) flip {
    if ([front superview]) {
        newEvent = [EKEvent eventWithEventStore: [Model sharedModel].eventStore];
        [Model sharedModel].currentNewEvent = newEvent;
    }
    [super flip];
}


- (void) awakeFromNib {
    [super awakeFromNib];

    datePickerView.clipsToBounds = YES;
    datePickerView.layer.masksToBounds = YES;
    datePickerView.layer.cornerRadius = 5.0;
}


- (IBAction) handleReserveButton: (id) sender {
}


- (IBAction) showDatePicker: (id) sender {

    currentButton = sender;

    UIView *superview = [datePickerView superview];
    if ([datePickerView superview]) [datePickerView removeFromSuperview];
    datePickerView.hidden = NO;

    UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromTop;

    [UIView transitionWithView: datePickerView
                      duration: 0.4
                       options: options
                    animations: ^{

                        [superview addSubview: datePickerView];
                    }
                    completion: NULL];
}


- (IBAction) dismissDatePicker: (id) sender {

    NSLog(@"datePicker.date = %@", datePicker.date);
    [UIView transitionWithView: datePickerView
                      duration: 0.3
                       options: UIViewAnimationOptionTransitionFlipFromTop
                    animations: ^{

                        datePickerView.hidden = YES;
                    }
                    completion: NULL];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"h:mm a";
    if (currentButton == startDateButton) {

        newEvent.startDate = datePicker.date;

        startDateButton.titleLabel.text = [formatter stringFromDate: datePicker.date];
    } else if (currentButton == endDateButton) {

        newEvent.endDate = datePicker.date;
        endDateButton.titleLabel.text = [formatter stringFromDate: datePicker.date];
    }
}
@end