//
//  CMSignals.m
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "CMSignals.h"
#import "CMConnection.h"
#define CM_SIGNALARGS @"CMSignalsArgs"

@interface CMSignals ()

@property (atomic, strong) NSMutableDictionary *connections;

- (NSString*)signalDescription:(SEL)signal withSender:(id)sender;

@end


@implementation CMSignals

+ (CMSignals *)sharedSingleton
{
    static CMSignals *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton) {
            sharedSingleton = [[CMSignals alloc] init];
            sharedSingleton.connections = [[NSMutableDictionary alloc] init];
        }
        return sharedSingleton;
    }
}

- (void)connectObject:(id)sender
                    with:(SEL)signal
                      to:(id)receiver
                    with:(SEL)slot
{
    assert(sender);
    
    NSString *signalDescription = [self signalDescription:signal withSender:sender];
    
    __block SEL _slot = slot;
    __block id _receiver = receiver;

    CMConnection *connection = [[CMConnection alloc] init];
    connection.sender = sender;
    connection.signal = signal;
    connection.receiver = receiver;
    connection.slot = slot;
    
    NSMutableSet *slots = [_connections objectForKey:signalDescription];

    if (!slots) {
        slots = [[NSMutableSet alloc] init];
    }

    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];

    connection.observer = [[NSNotificationCenter defaultCenter] addObserverForName:signalDescription
                                                      object:sender
                                                       queue:mainQueue
                                                  usingBlock:^(NSNotification *notification) {
                                                      NSArray *args = [notification.userInfo objectForKey:CM_SIGNALARGS];
                                                      NSMethodSignature *methodSignature = [_receiver methodSignatureForSelector:_slot];
                                                      
                                                      NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                                                      [invocation setTarget:_receiver];
                                                      [invocation setSelector:_slot];
                                                      for (NSUInteger i = 0; i < [args count]; ++i) {
                                                          id arg = [args objectAtIndex:i];
                                                          [invocation setArgument:&arg atIndex:i+2];
                                                      }
                                                      [invocation invoke];
                                                  }];
    [slots addObject:connection];
    [_connections setObject:slots forKey:signalDescription];
}

- (void)disconnectObject:(id)sender
                    with:(SEL)signal
                    from:(id)receiver
                    with:(SEL)slot
{
    NSString *signalDescription = [self signalDescription:signal withSender:sender];
    
    __block CMConnection *connection = [[CMConnection alloc] init];
    connection.sender = sender;
    connection.signal = signal;
    connection.receiver = receiver;
    connection.slot = slot;
    
    CMConnection *_connection = [[[_connections objectForKey:signalDescription] objectsPassingTest:^(CMConnection *obj,BOOL *stop){
        return [connection isEqual:obj];
    }] anyObject];

    [[NSNotificationCenter defaultCenter] removeObserver:_connection.observer];
    [[_connections objectForKey:signalDescription] removeObject:_connection];
}

- (void)emit:(SEL)signal object:(id)sender withArguments:(NSArray *)argsArray
{
    NSString *signalDescription = [self signalDescription:signal withSender:sender];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:signalDescription
                                                        object:sender
                                                      userInfo:@{ CM_SIGNALARGS :  argsArray }];
}

- (NSString*)signalDescription:(SEL)signal withSender:(id)sender
{
    return [NSString stringWithFormat:@"%@-%@-CMSignal", NSStringFromSelector(signal), [sender className]];
}


@end
