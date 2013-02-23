//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "UILabel+ECCalendar.h"


@implementation UILabel (ECCalendar)


- (void) format {

    self.font = [UIFont fontWithName: @"Antartida-Black" size: self.font.pointSize];
    self.text = [self.text uppercaseString];
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shadowOpacity = 1.0;
}

@end