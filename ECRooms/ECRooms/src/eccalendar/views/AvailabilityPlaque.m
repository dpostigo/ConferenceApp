//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AvailabilityPlaque.h"
#import "SVSegmentedControl.h"


@implementation AvailabilityPlaque {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {


    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];

//    SVSegmentedControl *slider = [[SVSegmentedControl alloc] initWithSectionTitles: [NSArray arrayWithObjects: @"About", @"Help", @"Credits", nil]];
    //    //        [slider addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    //
    //    slider.crossFadeLabelsOnDrag = YES;
    //    slider.thumb.tintColor = [UIColor colorWithRed: 0.6 green: 0.2 blue: 0.2 alpha: 1];
    //    slider.selectedIndex = 1;
    //
    //    UIImageView *imageView = [imageViews objectAtIndex: 0];
    //    NSLog(@"imageView = %@", imageView);
    //    slider.frame = imageView.frame;
    //    [self addSubview: slider];
}

@end