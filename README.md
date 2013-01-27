CMSignals
=========

[Qt Signals and Slots](http://en.wikipedia.org/wiki/Signals_and_slotshttp://en.wikipedia.org/wiki/Signals_and_slots) clone to Objective-c


Example
---------------------------

A class with a signal.

```objective-c
#import <Foundation/Foundation.h>
#import "NSObject+CMSignals.h"
@protocol CMExampleSignals

CM_signals

    - (void)signalMethod:(NSString *)string andNumber:(NSNumber *)number;

@end

@interface CMExample : NSObject <CMExampleSignals>

@end
```

A class with a slot

```objective-c
#import <Foundation/Foundation.h>
#import "NSObject+CMSignals.h"

@class CMExample;

@interface CMExampleReceiver : NSObject
- (id)initWithExample:(CMExample *)example;

- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number;

@end
```

```objective-c
#import "CMExampleReceiver.h"

@implementation CMExampleReceiver

- (id)initWithExample:(CMExample *)example
{
    self = [super init];
    
    if (self) {
        [self connect:@selector(signalMethod:andNumber:)
                    from:example
                    with:@selector(slotMethod:andNumber:)];
    }
    
    return self;
}


- (void)slotMethod:(NSString *)string andNumber:(NSNumber *)number
{
    NSLog(@"Slot called: %@ - %@", [number description], string);
}


@end
```

Somewhere on CMExample we execute:
```objective-c
 [self emit:@selector(signalMethod:andNumber:) withArguments:@[ @"Codeminer", [NSNumber numberWithInt:42]]];
```

And we get the slotMethod called.

Note that one can use the category on NSObject or use the singleton class CMSignals to connect, disconnect and emit signals/slots

Why not NSNotificationCenter?
-----------------------------

* Signal is a method definition;
* Slot is a method;
* No NSNotification treatment;
* No userInfo dictionary;
* Classes describe a well defined signal protocol.


CMSignals actually use NSNotificationCenter under the hood. CMSignals remove the boilerplate.

TODO
----

* `[ ]` Send broadcast signals using a class instead of an object;
* '[ ]' Make it a CocoaPod.
