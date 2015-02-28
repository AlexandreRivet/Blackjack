//
//  Dealer.m
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "Dealer.h"

@implementation Dealer

-(void)drawCard:(Deck*) deck
{
    Card * c = [deck drawCard];
    [self.hand addCard:c];
}

@end
