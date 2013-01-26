//
//  CMExampleReceiver.h
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+CMSignals.h"

@class CMExample;

@interface CMExampleReceiver : NSObject

- (id)initWithExample:(CMExample *)example;

#pragma mark Slots

- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number;

@end
