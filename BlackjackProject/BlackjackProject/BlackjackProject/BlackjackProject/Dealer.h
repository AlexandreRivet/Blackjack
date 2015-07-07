//
//  Dealer.h
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerModel.h"

@interface Dealer : PlayerModel

-(void)drawCard:(Deck*) deck;

@end
