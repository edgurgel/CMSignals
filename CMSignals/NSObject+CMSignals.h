//
//  NSObject+CMSignals.h
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//
#import "CMSignals.h"
#import <Foundation/Foundation.h>

@interface NSObject (CMSignals)

- (void)connect:(SEL)signal
           from:(id)sender
           with:(SEL)slot;

- (void)disconnect:(SEL)signal
              from:(id)sender
              with:(SEL)slot;

- (void)emit:(SEL)signal withArguments:(NSArray *)argsArray;


@end
