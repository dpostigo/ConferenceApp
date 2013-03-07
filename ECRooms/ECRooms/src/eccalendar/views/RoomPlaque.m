//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "RoomPlaque.h"
#import "Model.h"
#import "UILabel+ECCalendar.h"
#import "BasicWhiteView.h"


@implementation RoomPlaque {
    NSMutableArray *rooms;
}


@synthesize rooms;
@synthesize picker;
@synthesize titleLabel;
@synthesize table;


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

        rooms = [[NSMutableArray alloc] init];
        [rooms addObject: @"Meeting Cloud 1"];
        [rooms addObject: @"Meeting Field (Interactive)"];
        [rooms addObject: @"Meeting 550 Conference"];

        picker.height = 600;
        [table registerClass: [UITableViewCell class] forCellReuseIdentifier: @"RoomCell"];
    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];
}


- (void) flipToFront {
    BOOL isAvailable = [[Model sharedModel] availabilityForRoomType: [Model sharedModel].currentRoomType];

    if (isAvailable) {
        sliderHider.left = 13;
    } else {
        sliderHider.left = 132;
    }

    UIViewAnimationOptions options = [front superview] ? UIViewAnimationOptionTransitionFlipFromLeft: UIViewAnimationOptionTransitionFlipFromLeft;

    [UIView transitionWithView: self
                      duration: 0.5
                       options: options
                    animations: ^{

                        if ([back superview]) {
                            [back removeFromSuperview];
                        }
                        [self addSubview: front];
                    }
                    completion: ^(BOOL completion) {

                        NSLog(@"isAvailable = %d", isAvailable);
                        NSLog(@"sliderHider.left = %f", sliderHider.left);
                        if (isAvailable) {
                            [UIView animateWithDuration: 0.5 delay: 0.5 options: UIViewAnimationOptionCurveEaseOut animations: ^{
                                sliderHider.left = 132;
                            }                completion: nil];
                        } else {
                            [UIView animateWithDuration: 0.5 delay: 0.5 options: UIViewAnimationOptionCurveEaseOut animations: ^{
                                sliderHider.left = 13;
                            }                completion: nil];
                        }
                    }];
}

#pragma mark UIPickerViewDelegate






- (void) pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger) row inComponent: (NSInteger) component {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    RoomType roomType = (RoomType) row;
    [Model sharedModel].currentRoomType = roomType;

    titleLabel.text = [[Model sharedModel] slugForRoomType: roomType];
}


- (NSString *) pickerView: (UIPickerView *) pickerView titleForRow: (NSInteger) row forComponent: (NSInteger) component {
    return [rooms objectAtIndex: row];
}


- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView {
    return 1;
}


- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component {
    return [rooms count];
}


#pragma mark UITableView Delegate


#pragma mark UITableView Datasource

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
    return [rooms count];
}


- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
    NSString *string = [rooms objectAtIndex: indexPath.row];
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier: @"RoomCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"RoomCell"];
    }

    cell.textLabel.text = string;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell.textLabel format];
    cell.textLabel.font = [UIFont fontWithName: @"Antartida-Black" size: 13.0];

    cell.selectedBackgroundView = [[BasicWhiteView alloc] init];
    cell.selectedBackgroundView.layer.cornerRadius = 2.0;
    cell.selectedBackgroundView.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView.layer.masksToBounds = YES;
    cell.selectedBackgroundView.clipsToBounds = YES;

    return cell;
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

    [Model sharedModel].currentRoomType = (RoomType) indexPath.row;
    NSString *roomTypeString = [[Model sharedModel] currentRoomSlug];
    self.titleLabel.text = roomTypeString;
    [[Model sharedModel] notifyDelegates: @selector(currentRoomTypeDidChange) object: nil];
}

@end