//
//  Player.h
//  Blackjack
//
//  Created by arivet on 16/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "PlayerModel.h"

@interface Player : PlayerModel

-(id)initWithDeck:(Deck *)deck;
-(void)checkRules;
-(void)drawCard;
-(void)fold;

@end
