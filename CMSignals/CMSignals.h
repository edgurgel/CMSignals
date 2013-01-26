//
//  CMSignals.h
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CM_signals @optional

@interface CMSignals : NSObject

+ (CMSignals *)sharedSingleton;

- (void)connectObject:(id)sender
                    with:(SEL)signal
                      to:(id)receiver
                    with:(SEL)slot;

- (void)disconnectObject:(id)sender
                       with:(SEL)signal
                       from:(id)receiver
                       with:(SEL)slot;

- (void)emit:(SEL)signal object:(id)sender withArguments:(NSArray *)argsArray;

@end
