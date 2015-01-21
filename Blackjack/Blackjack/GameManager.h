//
//  GameManager.h
//  Blackjack
//
//  Created by Etudiant on 21/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Player.h"
#import "Dealer.h"

@interface GameManager : NSObject

@property(strong, nonatomic) Player * player;
@property(strong, nonatomic) Dealer * dealer;
@property(strong, nonatomic) Deck * discard;
@property(strong, nonatomic) Deck * cards;

-(id)init;

@end
