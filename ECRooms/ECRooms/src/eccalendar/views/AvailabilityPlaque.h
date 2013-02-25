//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "PlaqueView.h"


@interface AvailabilityPlaque : PlaqueView {
    IBOutletCollection(UIImageView) NSMutableArray *imageViews;
    IBOutletCollection(UILabel) NSMutableArray *labels;

    IBOutlet UITextField *eventTextField;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *datePickerView;

    IBOutlet UIButton *startDateButton;
    IBOutlet UIButton *endDateButton;
    IBOutlet UIButton *reserveButton;


}


@property(nonatomic, strong) UITextField *eventTextField;
@property(nonatomic, strong) NSMutableArray *labels;
@property(nonatomic, strong) NSMutableArray *imageViews;
@property(nonatomic, strong) UIButton *reserveButton;
- (IBAction) showDatePicker: (id) sender;
- (IBAction) dismissDatePicker: (id) sender;

@end