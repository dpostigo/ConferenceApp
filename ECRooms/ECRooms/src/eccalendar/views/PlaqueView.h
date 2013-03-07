//
// Created by dpostigo on 12/14/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface PlaqueView : UIView {
    IBOutlet UIView *front;
    IBOutlet UIView *back;

    BOOL isFront;

    BOOL isFlippedToFront;

}


@property(nonatomic) BOOL isFlippedToFront;
- (IBAction) flip;
- (void) flipToBack;
- (void) flipToFront;

@end