//
//  CMExample.h
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CMSignals.h"

@protocol  CMExampleSignals

CM_signals

    - (void)signalMethod:(NSString *)string andNumber:(NSNumber *)number;

@end

@interface CMExample : NSObject <CMExampleSignals>

#pragma mark Slots

- (void)testSignal;
- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number;

@end
