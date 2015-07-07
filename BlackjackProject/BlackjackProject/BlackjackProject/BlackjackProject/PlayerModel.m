//
//  PlayerModel.m
//  BlackjackProject
//
//  Created by arivet on 22/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

-(id) init;
{
    self = [super init];
    
    if (self)
    {
        self.hand = [[Hand alloc] init];
        self.state = Normal;
    }
    
    return self;
}

-(void)drawCard:(Deck*)deck
{
    NSAssert(false, @"drawCard not implemented");
}

@end
