//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <QuartzCore/QuartzCore.h>
#import "CustomTextField.h"


@implementation CustomTextField {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self setFont: [UIFont fontWithName: @"Antartida-Bold" size: self.font.pointSize]];
        self.text = [self.text uppercaseString];
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOpacity = 1.0;
    }

    return self;
}

@end