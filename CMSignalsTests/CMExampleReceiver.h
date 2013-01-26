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
@property (nonatomic, strong) CMExample *example;
- (id)initWithExample:(CMExample *)example;
- (void)disconnectSignals;
#pragma mark Slots

- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number;

@end
