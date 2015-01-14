//
//  Card.h
//  TestBlackjack
//
//  Created by arivet on 10/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    Spades,
    Clubs,
    Hearts,
    Diamonds
    
}Color;

@interface Card : NSObject

@property() int _numberCard;
@property() Color _colorCard;
@property() int _indexForValue;

-(id) initWithCardNumber:(int) numberCard color:(Color) colorCard;
-(NSArray*) getValue;
-(int) getNumberValue;
-(void) askForUserValue:(int) index;

@end

