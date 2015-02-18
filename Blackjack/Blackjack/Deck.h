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

@property(strong, nonatomic) NSMutableArray* cards;
@property(assign, nonatomic) NSInteger numberCardInit;
@property(assign, nonatomic) NSInteger numberCard;

-(id) initWithCards:(NSMutableArray*) cards;
-(Card*) drawCard;
-(void) shuffle;
-(void) addCard:(Card*) card withShuffle:(BOOL) isShuffle;
-(void) addCards:(NSMutableArray*) cards withShuffle:(BOOL) isShuffle;
-(NSString*) description;
+(Deck*)instanciateDeck;

@end
