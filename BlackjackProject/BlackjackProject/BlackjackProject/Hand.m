//
//  Hand.m
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "Hand.h"

@implementation Hand

-(id) init
{
    if ((self = [super init]))
    {
        _cards = [[NSMutableArray alloc] initWithCapacity:2];
        _isClosed = FALSE;
    }
    
    return self;
}

-(void) addCard:(Card*) card
{
    if (_isClosed == true && [self getNumberCards] != 0)
        card.isClosed = true;
    
    [_cards addObject:card];
}

-(NSInteger) getValue:(BOOL) force
{
    NSInteger value = 0;
    for (Card* c in _cards)
        value += [[[c getValue:force] objectAtIndex:c.indexForValue] integerValue];
    
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
-(void) setHandClosed:(BOOL)isClosed
{
    if (isClosed == false)
    {
        for (Card * c in _cards)
            c.isClosed = false;
    }
    
    _isClosed = isClosed;
}

@end
