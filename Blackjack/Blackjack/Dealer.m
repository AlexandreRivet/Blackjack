//
//  Dealer.m
//  Blackjack
//
//  Created by arivet on 16/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "Dealer.h"

@implementation Dealer

-(id)initWithDeck:(Deck *)deck
{
    self = [super initWithDeck:deck];
    
    if(self)
    {
        
    }
    
    return self;
}

-(void)drawCard
{
    if(self.state == Play)
    {
        if([self.hand getValue] < 17)
        {
            Card * card = [self.deck drawCard];
            
            if(card != nil)
            {
                [self.hand addCard:card];
                
                if([self.hand getValue] < 21)
                   [self fold];
                
                [self checkRules];
            }
        }
    }
    else
        NSLog(@"Dealer can't play");
}

@end
