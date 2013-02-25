//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "CustomButton.h"


@implementation CustomButton {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];


    self.titleLabel.font = [UIFont fontWithName: @"Antartida-Black" size: self.titleLabel.font.pointSize];

    self.titleLabel.text = [self.titleLabel.text uppercaseString];
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shadowOpacity = 1.0;
}

@end