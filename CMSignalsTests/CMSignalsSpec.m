#import "CMExample.h"
#import "CMExampleReceiver.h"
#import "Kiwi.h"

SPEC_BEGIN(CMSignalsSpec)

describe(@"CMSignalsSpec", ^{
    
    it(@"should not call slots", ^{
        CMExample *example = [[CMExample alloc] init];
        CMExampleReceiver *receiver = [[CMExampleReceiver alloc] initWithExample:example];
        
        [[CMSignals sharedSingleton] disconnectObject:example with:@selector(signalMethod:andNumber:) from:example with:@selector(slotMethod:andNumber:)];
        
        [[CMSignals sharedSingleton] disconnectObject:example with:@selector(signalMethod:andNumber:) from:receiver with:@selector(slotMethod:andNumber:)];
        
        [[example shouldNot] receive:@selector(slotMethod:andNumber:)];
        [[receiver shouldNot] receive:@selector(slotMethod:andNumber:)];

        [example testSignal];
        
    });
    
    it(@"should call slots", ^{
        CMExample *example = [[CMExample alloc] init];
        CMExampleReceiver *receiver = [[CMExampleReceiver alloc] initWithExample:example];
        [[example shouldEventually] receive:@selector(slotMethod:andNumber:)];
        [[receiver shouldEventually] receive:@selector(slotMethod:andNumber:)];
        [example testSignal];
        [[CMSignals sharedSingleton] disconnectObject:example with:@selector(signalMethod:andNumber:) from:example with:@selector(slotMethod:andNumber:)];
        [[CMSignals sharedSingleton] disconnectObject:example with:@selector(signalMethod:andNumber:) from:receiver with:@selector(slotMethod:andNumber:)];
    });
    
});

SPEC_END