//
//  GameManager.h
//  BlackjackProject
//
//  Created by arivet on 25/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "Player.h"
#import "Dealer.h"
#import "Card.h"

@interface GameManager : UIViewController <UIAlertViewDelegate>

@property(assign, nonatomic) CGRect screenRect;

@property(strong, nonatomic) UILabel * playerLabel;
@property(strong, nonatomic) UILabel * dealerLabel;
@property(strong, nonatomic) UILabel * bankrollLabel;

@property(strong, nonatomic) UIButton * exitButton;

@property(strong, nonatomic) UIButton * drawButton;
@property(strong, nonatomic) UIButton * standButton;

@property(strong, nonatomic) UIButton * surrenderButton;
@property(strong, nonatomic) UIButton * playAgainButton;

@property(strong, nonatomic) UIButton * separateButton;
@property(strong, nonatomic) UIButton * doubleButton;
@property(strong, nonatomic) UIButton * insuranceButton;

@property(strong, nonatomic) Player * player;
@property(strong, nonatomic) Dealer * dealer;
@property(strong, nonatomic) Deck * cards;
@property(strong, nonatomic) Deck * discards;
@property(strong, nonatomic) NSMutableArray * allImageView;
@property(strong, nonatomic) NSMutableArray * imageViewJetons;

@property(assign, nonatomic) int currentCard;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

-(void)initBoard;
-(void)chooseBet;
-(void)setup;

-(void)playerDrawFromButton;
-(void)playerDraws;
-(void)playerDoubles;
-(void)playerSurrends;
-(void)playerStands;
-(void)playerAssures;
-(void)playerReplays;

-(void)dealerPlays;
-(void)dealerDraws;

-(void)checkPlayerLoss;
-(void)checkWinner;
-(void) endGame:(int)winner withMessage:(NSString*)message;

-(void) animateCard:(Card*)card fromPos:(CGPoint)start toPos:(CGPoint)end withAngle:(CGFloat)angle flipFlapAtEnd:(BOOL)isFlipping;
-(void) animateImageView:(UIImageView*)imageView fromPos:(CGPoint)start toPos:(CGPoint)end withAngle:(CGFloat)angle withDestroy:(BOOL) isDestroyed;
-(void) flipCard:(Card*) card;

-(void)reset;
-(void)quit;

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;


@end
