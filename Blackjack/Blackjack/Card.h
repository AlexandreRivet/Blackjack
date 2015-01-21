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

@property(assign, nonatomic) int _numberCard;
@property(assign, nonatomic) Color _colorCard;
@property(assign, nonatomic) int _indexForValue;
@property(assign, nonatomic) BOOL _isClosed;

-(id) initWithCardNumber:(int) numberCard color:(Color) colorCard;
-(NSArray*) getValue;
-(int) getNumberValue;
-(void) askForUserValue:(int) index;
-(NSString*) getFilename;

@end

