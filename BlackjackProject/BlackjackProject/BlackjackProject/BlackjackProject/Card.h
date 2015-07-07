//
//  Card.h
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    Spades,
    Clubs,
    Hearts,
    Diamonds
    
}Color;

@interface Card : NSObject

@property(assign, nonatomic) int numberCard;
@property(assign, nonatomic) Color colorCard;
@property(assign, nonatomic) int indexForValue;
@property(assign, nonatomic) BOOL isClosed;
@property(assign, nonatomic) int imageViewIndex;

-(id) initWithCardNumber:(int) numberCard color:(Color) colorCard;
-(NSArray*) getValue:(BOOL) force;
-(int) getNumberValue;
-(void) askForUserValue:(int) index;
-(NSString*) getFilename;

@end
