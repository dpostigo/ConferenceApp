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

    NSLog(@"_model.currentNewEvent.title = %@", _model.currentNewEvent.title);

    if (_model.currentNewEvent.title == nil || [_model.currentNewEvent.title isEqualToString: @""]) {
        NSString *message = @"No event title has been set.";
        [_model notifyDelegates: @selector(eventFailedWithMessage:) object: message];
    }

    else {
        EKEventStore *store = _model.eventStore;
        NSError *error = nil;

        _model.currentNewEvent.calendar = _model.currentCalendar;
        [store saveEvent: _model.currentNewEvent span: EKSpanThisEvent commit: YES error: &error];

        if (error) {
            [_model notifyDelegates: @selector(eventFailedWithMessage:) object: error.localizedDescription];
        }
    }
}

@end