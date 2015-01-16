//
//  PlayerModel.m
//  Blackjack
//
//  Created by arivet on 16/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

-(id) initWithDeck:(Deck*)deck;
{
    self = [super init];
    
    if (self)
    {
        self.hand = [[Hand alloc] init];
        self.state = Play;
    }
    
    return self;
}

-(void)checkRules
{
    if([self.hand getValue] == 21)
        self.state = Win;
    
    if (self.hand.getValue > 21)
        self.state = Loose;
}

-(void)drawCard
{}

-(void)fold
{
    self.state = Fold;
}

@end
