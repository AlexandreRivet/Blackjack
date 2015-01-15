//
//  GameScene.m
//  Blackjack
//
//  Created by arivet on 14/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"BlackJack";
    myLabel.fontSize = 65;
    myLabel.fontColor = [UIColor blackColor];
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                            CGRectGetHeight(self.frame)/3 * 2);
    
    [self addChild:myLabel];
    
    self._buttonPlay = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    self._buttonPlay.text = @"Play";
    self._buttonPlay.fontSize = 65;
    self._buttonPlay.fontColor = [UIColor redColor];
    self._buttonPlay.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    
    [self addChild:self._buttonPlay];
    
    
    self._buttonQuit = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    self._buttonQuit.text = @"Exit";
    self._buttonQuit.fontSize = 32;
    self._buttonQuit.fontColor = [UIColor redColor];
    self._buttonQuit.position = CGPointMake(CGRectGetMidX(self.frame),
                                            CGRectGetHeight(self.frame)/3);
    
    
    [self addChild:self._buttonQuit];
    
    //Création d'un sprite qui tourne
    NSArray *sprites = [[NSArray alloc	] init];
   
    SKSpriteNode *sprite= [SKSpriteNode spriteNodeWithImageNamed:@"1_carreau"];
    sprites = [sprites arrayByAddingObject:sprite];
    
    sprite= [SKSpriteNode spriteNodeWithImageNamed:@"1_coeur"];
    sprites = [sprites arrayByAddingObject:sprite];
    
    sprite= [SKSpriteNode spriteNodeWithImageNamed:@"1_pique"];
    sprites = [sprites arrayByAddingObject:sprite];
    
    sprite= [SKSpriteNode spriteNodeWithImageNamed:@"1_trefle"];
    sprites = [sprites arrayByAddingObject:sprite];

    for(int i = 0; i < 4; i++)
    {
        sprite = [sprites objectAtIndex:i];
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
    sprite = [sprites objectAtIndex:0];
    sprite.position = CGPointMake((CGRectGetWidth(self.frame)/3),
                                      CGRectGetHeight(self.frame)/3);
    
    sprite = [sprites objectAtIndex:1];
    sprite.position = CGPointMake((CGRectGetWidth(self.frame)/3 * 2),
                                      CGRectGetHeight(self.frame)/3);
    
    sprite = [sprites objectAtIndex:2];
    sprite.position = CGPointMake((CGRectGetWidth(self.frame)/3),
                                      CGRectGetHeight(self.frame)/3 * 2);
    
    sprite = [sprites objectAtIndex:3];
    sprite.position = CGPointMake((CGRectGetWidth(self.frame)/3 * 2),
                                  CGRectGetHeight(self.frame)/3 * 2);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
        if(CGRectContainsPoint(self._buttonPlay.frame, location)) {
            // do whatever for first menu
        }
        else if(CGRectContainsPoint(self._buttonQuit.frame, location)) {
            // do whatever for first menu
            exit(0);
        }
        else
        {
            
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"1_trefle"];
            sprite.xScale = 0.5;
            sprite.yScale = 0.5;
            sprite.position = location;
            
            SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
            
            [sprite runAction:[SKAction repeatActionForever:action]];
            
            [self addChild:sprite];
        }
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

/*

- (id) initWithSize:(CGSize)size // can't fully remember this one...
{
     if(self = [super initWithSize:size]) {
        // here you create your labels
        menuItem1 = [SKLabelNode labelNodeWithFontNamed:@"Your font."];

        // this will position this at the center, top 1/3 of the screen
        menuItem1.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * .3); 
        menuItem1.text = @"Menu 1";
        [self addChild:menuItem1]; // takes care of the first

        menuItem2 = [SKLabelNode labelNodeWithFontNamed:@"Your font."];

        // place at center, lower 1/3 of screen
        menuItem2.position = CGPointMake(self.frame.size.width/2, self.frame.size.height * .6); 
        menuItem2.text = @"Menu 2";
        [self addChild:menuItem2];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     UITouch *t = [touches anyObject];
     CGPoint touchLocation = [t locationInNode:self.scene];

      if(CGRectContainsPoint(menuItem1.frame, touchLocation)) {
          // do whatever for first menu
      }

      if(CGRectContainsPoint(menuItem2.frame, touchLocation)) {
          // do whatever for second menu
      }
}

*/
@end
