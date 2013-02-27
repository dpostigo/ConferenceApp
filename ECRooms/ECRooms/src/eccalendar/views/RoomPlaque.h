//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "PlaqueView.h"
#import "CustomLabel.h"


@interface RoomPlaque : PlaqueView  <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIPickerView *picker;
    IBOutlet CustomLabel *titleLabel;
    IBOutlet UITableView *table;
    IBOutlet UIImageView *sliderHider;
}


@property(nonatomic, strong) NSMutableArray *rooms;
@property(nonatomic, strong) UIPickerView *picker;
@property(nonatomic, strong) CustomLabel *titleLabel;
@property(nonatomic, strong) UITableView *table;

@end