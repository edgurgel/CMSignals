//
//  CMConnection.m
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMConnection.h"

@implementation CMConnection

- (BOOL)isEqual:(CMConnection *)object
{
    assert([object isKindOfClass:[CMConnection class]]);
    
    if (![_sender isEqual:object.sender])
        return NO;
    if (![_receiver isEqual:object.receiver])
        return NO;
    if (![NSStringFromSelector(_slot) isEqualToString: NSStringFromSelector(object.slot)])
        return NO;
    if (![NSStringFromSelector(_signal) isEqualToString: NSStringFromSelector(object.signal)])
        return NO;
    return YES;
}

- (id)copyWithZone:(NSZone *)zone
{
    CMConnection *copy = [[[CMConnection class] alloc] init];
    
    if (copy) {
        copy.sender = self.sender;
        copy.signal = self.signal;
        copy.receiver = self.receiver;
        copy.slot = self.slot;
    }
    
    return copy;
}

@end
