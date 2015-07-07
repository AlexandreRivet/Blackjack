//
//  PlayerModel.h
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Hand.h"

typedef enum {
    
    Normal,
    Double,
    Insurance,
    Surrend
    
}PlayerState;

@interface PlayerModel : NSObject

@property(assign, nonatomic) PlayerState state;
@property(strong, nonatomic) Hand* hand;

-(id) init;
-(void)drawCard:(Deck*) deck;

@end
