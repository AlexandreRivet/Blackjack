//
//  Card.m
//  TestBlackjack
//
//  Created by arivet on 10/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "Card.h"

@implementation Card

-(id) initWithCardNumber:(int)numberCard color:(Color)colorCard
{
    if (self = [super init])
    {
        self._numberCard = numberCard;
        self._colorCard = colorCard;
        self._indexForValue = 0;
    }
    return self;
}

-(NSArray*) getValue
{

    if(self._numberCard >= 10)
        return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:10], nil];
    else if(self._numberCard == 1)
        return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:1], [NSNumber numberWithInt:11], nil];
    else
        return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:self._numberCard], nil];
}

-(int) getNumberValue
{
    return (self._numberCard == 1) ? 2 : 1;
}

-(void) askForUserValue:(int) index
{
    if (index < [self getNumberValue])
        self._indexForValue = index;
}

-(NSString*) numberCardAsString
{
    switch (self._numberCard)
    {
        case 1:
            return @"Ace";
            break;
        
        case 11:
            return @"Jack";
            break;
        
        case 12:
            return @"Queen";
            break;
        
        case 13:
            return @"King";
            break;
            
            
        default:
            return [NSString stringWithFormat:@"%d", self._numberCard];
            break;
    }
}

-(NSString*) colorAsString
{
    switch (self._colorCard)
    {
        case Spades:
            return @"Spades";
            break;
        
        case Clubs:
            return @"Clubs";
            break;
        
        case Hearts:
            return @"Hearts";
            break;
        
        case Diamonds:
            return @"Diamonds";
            
        default:
            return nil;
            break;
    }
}

-(NSString*) valueAsString
{
    NSMutableString* string_tmp = [[NSMutableString alloc] init];
    NSArray* values = [self getValue];
    
    int nbValues = [self getNumberValue];
    for(int i = 0; i < nbValues; i++)
    {
        if (i > 0)
            [string_tmp appendString:@"|"];
        NSString* tmp = [[NSString alloc] initWithFormat:@"%@", [values objectAtIndex:i] ];
        [string_tmp appendString:tmp];
    }
    
    return [NSString stringWithString:string_tmp];
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@ : values => (%@)", [self numberCardAsString], [self colorAsString], [self valueAsString]];
}

@end
