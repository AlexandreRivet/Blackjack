//
//  Player.m
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)init
{
    self = [super init];
    
    if (self != nil)
        _bankroll = 1000;
    
    return self;
}

-(void)drawCard:(Deck*)deck
{
    Card * c = [deck drawCard];
    [self.hand addCard:c];
}

-(void)setBankroll:(int)bankroll
{
    _bankroll = bankroll;
}

-(void)setCurrentBet:(int)currentBet
{
    _currentBet = currentBet;
}

@end
