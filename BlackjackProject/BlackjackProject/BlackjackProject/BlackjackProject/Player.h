//
//  Player.h
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerModel.h"

@interface Player : PlayerModel

@property(assign, nonatomic) int bankroll;
@property(assign, nonatomic) int currentBet;

-(void)drawCard:(Deck*)deck;
-(void)setBankroll:(int)bankroll;
-(void)setCurrentBet:(int)currentBet;

@end
