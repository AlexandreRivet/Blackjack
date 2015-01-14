//
//  Hand.h
//  TestBlackjack
//
//  Created by arivet on 13/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Hand : NSObject

@property() NSMutableArray* _cards;

-(void) addCard:(Card*) card;
-(NSInteger) getValue;
-(NSInteger) getNumberCards;
-(Card *) getCardAtIndex:(NSInteger) index;

@end
