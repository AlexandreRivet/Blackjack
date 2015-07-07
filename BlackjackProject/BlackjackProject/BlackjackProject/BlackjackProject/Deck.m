//
//  Deck.m
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        _cards = [[NSMutableArray alloc] init];
        _numberCardInit = 0;
    }
    
    return self;
}

-(id) initWithCards:(NSMutableArray*) cards
{
    self = [super init];
    
    if(self != nil)
    {
        _cards = [[NSMutableArray alloc] init];
        [_cards addObjectsFromArray:cards];
        [self shuffle];
        
        _numberCardInit = _cards.count;
    }
    
    return self;
}

-(Card*) drawCard
{
    if ([_cards count] > 0)
    {
        Card* c = [_cards lastObject];
        [_cards removeObject:c];
        _numberCard = [_cards count];
        
        return c;
    }
    
    return nil;
}

-(void) removeAllCards
{
    [_cards removeAllObjects];
}

-(void) shuffle
{
    NSUInteger count = [_cards count];
    
    unsigned long indexElement = 0, element = 0;
    for (NSUInteger i = 0; i < count; i++)
    {
        element = count - i;
        indexElement = (arc4random() % element) + i;
        [_cards exchangeObjectAtIndex:i withObjectAtIndex:indexElement];
    }
}

-(void) addCard:(Card*) card withShuffle:(BOOL) isShuffle
{
    if (card != nil)
    {
        [_cards addObject:card];
        ++_numberCard;
        
        if (isShuffle)
            [self shuffle];
    }
}

-(void) addCards:(NSMutableArray*) cards withShuffle:(BOOL) isShuffle
{
    if (cards != nil)
    {
        [_cards addObjectsFromArray:cards];
        
        _numberCard += cards.count;
        
        if (isShuffle)
            [self shuffle];
    }
}

-(void) addCardsFromDeck:(Deck*) deck withShuffle:(BOOL) isShuffle
{
    if (deck != nil)
        [self addCards:deck.cards withShuffle:isShuffle];
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"Deck: %@", _cards];
}

+(Deck*) instanciateDeck
{
    NSMutableArray * cards = [[NSMutableArray alloc] init];
    
    int numberDeck = 6;
    
    for (int i = 0; i < numberDeck; ++i)
    {
        for (int color = 0; color <= 3; ++color)
        {
            for (int numberCard = 1; numberCard <= 13; ++numberCard)
            {
                [cards addObject:[[Card alloc] initWithCardNumber:numberCard color:color]];
            }
        }
    }
    
    Deck * deck = [[Deck alloc] initWithCards:cards];
    [deck shuffle];
    
    return deck;
}


@end
