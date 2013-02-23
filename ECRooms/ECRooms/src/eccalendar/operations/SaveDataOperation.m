//
// Created by dpostigo on 2/22/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SaveDataOperation.h"


@implementation SaveDataOperation {
}


- (void) main {
    [super main];

    [[NSUserDefaults standardUserDefaults] setObject: [NSNumber numberWithInteger: (NSInteger) _model.currentRoomType] forKey: @"roomType"];
}

@end