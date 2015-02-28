//
//  Hand.h
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Hand : NSObject

@property(strong, nonatomic) NSMutableArray* cards;
@property(assign, nonatomic) BOOL isClosed;

-(void) addCard:(Card*) card;
-(NSInteger) getValue:(BOOL) force;
-(NSInteger) getNumberCards;
-(Card *) getCardAtIndex:(NSInteger) index;
-(void) setHandClosed:(BOOL)isClosed;

@end
