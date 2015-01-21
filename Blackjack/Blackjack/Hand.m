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
        _cards = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    return self;
}

-(void) addCard:(Card*) card
{
    [_cards addObject:card];
}

-(NSInteger) getValue
{
    NSInteger value = 0;
    for (Card* c in _cards)
        value += [[[c getValue] objectAtIndex:c.indexForValue] integerValue];
    
    return value;
}

-(NSInteger) getNumberCards
{
    return [_cards count];
}

-(Card *) getCardAtIndex:(NSInteger) index
{
    return [_cards objectAtIndex:index];
}

@end
