//
// Created by dpostigo on 12/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PlaqueView.h"


@implementation PlaqueView {
}


- (id) initWithCoder: (NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {

        [self addSubview: front];
        NSLog(@"front = %@", front);
        NSLog(@"%s", __PRETTY_FUNCTION__);
    }

    return self;
}


- (void) awakeFromNib {
    [super awakeFromNib];
    NSLog(@"front = %@", front);
    [self addSubview: front];
}


- (IBAction) flip {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    UIViewAnimationOptions options = [front superview] ? UIViewAnimationOptionTransitionFlipFromBottom : UIViewAnimationOptionTransitionFlipFromTop;

    [UIView transitionWithView: self
                      duration: 0.5
                       options: options
                    animations: ^{

                        if ([front superview]) {
                            [front removeFromSuperview];
                            [self addSubview: back];

                        }

                        else {

                            [back removeFromSuperview];
                            [self addSubview: front];
                        }

                    }
                    completion: NULL];
}
@end