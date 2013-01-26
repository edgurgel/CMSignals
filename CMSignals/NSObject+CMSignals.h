//
//  NSObject+CMSignals.h
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CM_signals @optional

@interface NSObject (CMSignals)

- (void)CM_connect:(SEL)signal
              from:(id)sender
              with:(SEL)slot;

- (void)CM_disconnect:(SEL)signal
                 from:(id)sender
                 with:(SEL)slot;

- (void)CM_emit:(SEL)signal withArguments:(NSArray *)argsArray;


@end
