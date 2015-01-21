//
//  Deck.h
//  TestBlackjack
//
//  Created by arivet on 13/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

@property(strong, nonatomic) NSMutableArray* _cards;
@property(strong, nonatomic) NSMutableArray* _discards;
@property(assign, nonatomic) NSInteger _percentDiscard;
@property(assign, nonatomic) NSInteger _numberCardInit;

-(id) initWithCards:(NSMutableArray*) cards;
-(NSUInteger) getNumberCards;
-(Card*) drawCard;
-(void) shuffle;
-(void) addCard:(Card*) card withShuffle:(BOOL) isShuffle;
-(void) addCards:(NSMutableArray*) cards withShuffle:(BOOL) isShuffle;
-(NSString*) description;

@end
