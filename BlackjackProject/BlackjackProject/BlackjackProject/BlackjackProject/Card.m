//
//  Card.m
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "Card.h"

@implementation Card

-(id) initWithCardNumber:(int)numberCard color:(Color)colorCard
{
    if (self = [super init])
    {
        _numberCard = numberCard;
        _colorCard = colorCard;
        _indexForValue = 0;
        _isClosed = false;
    }
    return self;
}

-(NSArray*) getValue:(BOOL) force
{
    if (_isClosed && !force)
    {
        if (_numberCard == 1)
            return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
        else
            return [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
    }
    else if(_numberCard >= 10)
        return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:10], nil];
    else if(_numberCard == 1)
        return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:1], [NSNumber numberWithInt:11], nil];
    else
        return [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:_numberCard], nil];
}

-(int) getNumberValue
{
    return (_numberCard == 1) ? 2 : 1;
}

-(void) askForUserValue:(int) index
{
    if (index < [self getNumberValue])
        _indexForValue = index;
}

-(NSString*) numberCardAsString
{
    switch (_numberCard)
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
            return [NSString stringWithFormat:@"%d", _numberCard];
            break;
    }
}

-(NSString*) colorAsString
{
    switch (_colorCard)
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
    NSArray* values = [self getValue:YES];
    
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

-(NSString*) getFilename
{
    if (_isClosed)
        return [NSString stringWithFormat:@"cover.png"];
    else
        return [NSString stringWithFormat:@"%@_%@.png", [self numberCardAsString], [self colorAsString]];
}

@end
