#import "CMExample.h"
#import "CMExampleReceiver.h"
#import "Kiwi.h"

SPEC_BEGIN(CMSignalsSpec)

describe(@"CMSignalsSpec", ^{
    it(@"should call slots", ^{
        CMExample *example = [[CMExample alloc] init];
        CMExampleReceiver *receiver = [[CMExampleReceiver alloc] initWithExample:example];
        [[example shouldEventually] receive:@selector(slotMethod:andNumber:)];
        [[receiver shouldEventually] receive:@selector(slotMethod:andNumber:)];
        [example testSignal];
        
    });
});

SPEC_END