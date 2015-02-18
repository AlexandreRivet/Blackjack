//
//  GameManager.m
//  Blackjack
//
//  Created by Etudiant on 21/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "GameManager.h"

@implementation GameManager

-(id)init
{
    self = [self init];
    
    if(self != nil)
    {
        _player = [[Player alloc] init];
        _dealer = [[Dealer alloc] init];
        
        _cards = [Deck instanciateDeck];
        _discard = [[Deck alloc] init];
        
    }
    
    return self;
}

@end
