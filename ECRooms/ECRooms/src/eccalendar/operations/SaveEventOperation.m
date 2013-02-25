//
// Created by dpostigo on 2/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SaveEventOperation.h"


@implementation SaveEventOperation {
}


- (void) main {
    [super main];

    EKEventStore *store = _model.eventStore;
    NSError *error = nil;

    [store saveEvent: _model.currentNewEvent span: EKSpanThisEvent commit: YES error: &error];
}

@end