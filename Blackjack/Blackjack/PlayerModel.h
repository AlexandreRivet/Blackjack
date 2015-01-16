//
//  PlayerModel.h
//  Blackjack
//
//  Created by arivet on 16/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Hand.h"

typedef enum {
    
    Play,
    Win,
    Loose,
    Fold
    
}PlayerState;

@interface PlayerModel : NSObject

@property() PlayerState state;
@property(weak, nonatomic) Deck* deck;
@property(strong, nonatomic) Hand* hand;

-(id) initWithDeck:(Deck*)deck;
-(void)checkRules;
-(void)drawCard;
-(void)fold;

@end
