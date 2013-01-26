//
//  CMExampleReceiver.m
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMExampleReceiver.h"
#import "CMExample.h"


@implementation CMExampleReceiver

- (id)initWithExample:(CMExample *)example
{
    self = [super init];
    
    if (self) {
        [self CM_connect:@selector(signalMethod:andNumber:)
                    from:example
                    with:@selector(slotMethod:andNumber:)];
    }
    
    return self;
}

#pragma mark Slots

- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number
{
    NSLog(@"%@ - %@", [number description], string);
}

@end
