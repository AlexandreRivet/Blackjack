//
//  Deck.m
//  TestBlackjack
//
//  Created by arivet on 13/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(id) initWithCards:(NSMutableArray*) cards
{
    self._cards = [[NSMutableArray alloc] init];
    [self._cards addObjectsFromArray:cards];
    [self shuffle];
    
    self._discards = [[NSMutableArray alloc] init];
    
    self._percentDiscard = 25;
    self._numberCardInit = [self getNumberCards];
    
    return self;
}

-(NSUInteger) getNumberCards
{
    return [self._cards count];
}

-(Card*) drawCard
{
    if ([self._cards count] > 0)
    {
        Card* c = [self._cards lastObject];
        [self._discards addObject:c];
        [self._cards removeLastObject];
        
        NSInteger current_percent = (NSInteger) ([self getNumberCards] / self._numberCardInit) * 100;
        if ( current_percent <= self._percentDiscard)
            [self._cards addObjectsFromArray:self._discards];
        
        return c;
    }
    
    return nil;
}

-(void) shuffle
{
    NSUInteger count = [self._cards count];
    
    unsigned long indexElement = 0, element = 0;
    for (NSUInteger i = 0; i < count; i++)
    {
        element = count - i;
        indexElement = (arc4random() % element) + i;
        [self._cards exchangeObjectAtIndex:i withObjectAtIndex:indexElement];
    }
}

-(void) addCard:(Card*) card withShuffle:(BOOL) isShuffle
{
    if (card != nil)
    {
        [self._cards addObject:card];
        if (isShuffle)
            [self shuffle];
    }
}

-(void) addCards:(NSMutableArray*) cards withShuffle:(BOOL) isShuffle
{
    if (cards != nil)
    {
        [self._cards addObjectsFromArray:cards];
        if (isShuffle)
            [self shuffle];
    }
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"Deck: %@", self._cards];
}

@end
