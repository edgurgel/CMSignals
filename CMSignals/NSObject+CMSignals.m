//
//  NSObject+CMSignals.m
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import "NSObject+CMSignals.h"

#define CM_SIGNALARGS @"CMSignalsArgs"

@implementation NSObject (CMSignals)


- (void)CM_connect:(SEL)signal
             from:(id)sender
           with:(SEL)slot
{
    assert(sender);
    
    NSString *signalDescription = [self CM_signalDescription:signal withSender:sender];

    __block SEL _slot = slot;

    [[NSNotificationCenter defaultCenter] addObserverForName:signalDescription
                                                      object:sender
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification) {
                                                      NSArray *args = [notification.userInfo objectForKey:CM_SIGNALARGS];
                                                      NSMethodSignature *methodSignature = [self methodSignatureForSelector:_slot];

                                                      NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                                                      [invocation setTarget:self];
                                                      [invocation setSelector:_slot];
                                                      for (NSUInteger i = 0; i < [args count]; ++i) {
                                                          id arg = [args objectAtIndex:i];
                                                          [invocation setArgument:&arg atIndex:i+2];
                                                      }
                                                      [invocation invoke];
                                                  
                                                  }];
}

- (void)CM_disconnect:(SEL)signal
                 from:(id)sender
                 with:(SEL)slot
{
    NSString *signalDescription = [self CM_signalDescription:signal withSender:sender];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:signalDescription object:sender];
}

- (void)CM_emit:(SEL)signal withArguments:(NSArray *)argsArray
{

    NSString *signalDescription = [self CM_signalDescription:signal withSender:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:signalDescription
                                                        object:self
                                                      userInfo:@{ CM_SIGNALARGS :  argsArray }];
}

- (NSString*)CM_signalDescription:(SEL)signal withSender:(id)sender
{
    return [NSString stringWithFormat:@"%@-%@-CMSignal", NSStringFromSelector(signal), [sender className]];
}

//
//- (void)CM_router:(NSNotification *)notification
//{
//    NSArray *args = [notification.userInfo objectForKey:CM_SIGNALARGS];
//    [receiver method: dfodks]
//}
@end
