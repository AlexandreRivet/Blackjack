//
//  Player.m
//  Blackjack
//
//  Created by arivet on 16/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "Player.h"

@implementation Player


-(id)initWithDeck:(Deck*)deck
{
    self = [super initWithDeck:deck];
    
    if( self)
    {
        
    }
	
    return self;
}

-(void)drawCard
{
    Card * card = [self.deck drawCard];
    
    if(card != nil)
        [self.hand addCard:card];
}

@end
