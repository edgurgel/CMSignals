//
//  CMConnection.h
//  CMSignals
//
//  Created by Tiago Bastos on 26/01/2013.
//  Copyright (c) 2013 Codeminer42. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMConnection : NSObject <NSCopying>

@property (nonatomic, strong) id sender;
@property (nonatomic, strong) id receiver;

@property (assign) SEL slot;
@property (assign) SEL signal;

@property (assign) id observer;

@end
