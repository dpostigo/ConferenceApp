//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "PlaqueView.h"


@interface AvailabilityPlaque : PlaqueView {
    IBOutletCollection(UIImageView) NSMutableArray *imageViews;
}


@end