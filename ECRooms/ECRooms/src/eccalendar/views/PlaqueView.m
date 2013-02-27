//
// Created by dpostigo on 12/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaqueView.h"


@implementation PlaqueView {
}


@synthesize isFlippedToFront;


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

        isFlippedToFront = YES;
        [self addSubview: front];
    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];
    [self addSubview: front];
}


- (IBAction) flip {
    if ([front superview]) {
        [self flipToBack];
    } else {
        [self flipToFront];
    }
}


- (void) flipToBack {

    UIViewAnimationOptions options = [front superview] ? UIViewAnimationOptionTransitionFlipFromLeft: UIViewAnimationOptionTransitionFlipFromLeft;

    [UIView transitionWithView: self
                      duration: 0.5
                       options: options
                    animations: ^{

                        if ([front superview]) {
                            [front removeFromSuperview];
                        }

                        [self addSubview: back];
                    }
                    completion: ^(BOOL completion) {
                        isFlippedToFront = NO;


                    }];
}


- (void) flipToFront {

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

                        isFlippedToFront = YES;
                    }];
}
@end