//
//  CMExample.m
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMExample.h"

@implementation CMExample

#pragma mark Signals

- (id)init
{
    self = [super init];

    if (self) {
        [self connect:@selector(signalMethod:andNumber:) from:self with:@selector(slotMethod:andNumber:)];
    }

    return self;
}

#pragma mark Slots

- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number
{
    NSLog(@"%@ - %@", string, [number description]);
}

- (void)testSignal
{
    [self emit:@selector(signalMethod:andNumber:) withArguments:@[ @"Codeminer", [NSNumber numberWithInt:42]]];
}

@end
