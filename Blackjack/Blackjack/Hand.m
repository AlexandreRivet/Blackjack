//
//  Hand.m
//  TestBlackjack
//
//  Created by arivet on 13/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "Hand.h"

@implementation Hand

-(id) init
{
    if ((self = [super init]))
    {
        self._cards = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    return self;
}

-(void) addCard:(Card*) card
{
    [self._cards addObject:card];
}

-(NSInteger) getValue
{
    NSInteger value = 0;
    for (Card* c in self._cards)
        value += [[[c getValue] objectAtIndex:c._indexForValue] integerValue];
    
    return value;
}

-(NSInteger) getNumberCards
{
    return [self._cards count];
}

-(Card *) getCardAtIndex:(NSInteger) index
{
    return [self._cards objectAtIndex:index];
}

@end
