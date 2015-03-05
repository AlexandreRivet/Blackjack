//
//  GameManager.m
//  BlackjackProject
//
//  Created by arivet on 25/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "GameManager.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
#define WIDTH_TABLE 1334
#define HEIGHT_TABLE 750
#define WIDTH_SLOT 50
#define HEIGHT_SLOT 70
#define ALERTVIEW_BET 1
#define ALERTVIEW_ACE 2
#define ALERTVIEW_WINNER 3

@interface GameManager ()

@end

@implementation GameManager

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBoard];
    [self chooseBet];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   
    if (self != nil)
    {
        _cards = [Deck instanciateDeck];
        _discards = [[Deck alloc] init];
        
        _player = [[Player alloc] init];
        
        _dealer = [[Dealer alloc] init];
        
        _allImageView = [[NSMutableArray alloc] init];
        _imageViewJetons = [[NSMutableArray alloc] init];
        
        _screenRect = [[UIScreen mainScreen] bounds];
        [self.view setFrame:_screenRect];
    }
    
    return self;
}


-(void) initBoard
{
    // Récupération de la taille écran
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    
    // Ajout de la table
    UIImage * cImage = [UIImage imageNamed:@"table.png"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:cImage];
    CGRect rect = CGRectMake(0, 0, w, h);
    imageView.frame = rect;
    [self.view addSubview:imageView];
    
    CGFloat wImg = (w * WIDTH_SLOT) / WIDTH_TABLE;
    CGFloat hImg = (h * HEIGHT_SLOT) / HEIGHT_TABLE;
    
    // Initialisation du tas de cartes
    for (int i = 0; i < 4; i++)
    {
        UIImage * cImage = [UIImage imageNamed:@"cover.png"];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:cImage];
        CGRect rect = CGRectMake((w * 0.68) + i, (h * 0.28), wImg, hImg);
        imageView.frame = rect;
        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-60));
        
        [self.view addSubview:imageView];
    }
    
    // Initialisation des boutons
    // Quitter
    _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.05, h * 0.85, 55, 40)];
    [_exitButton setBackgroundImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    [_exitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_exitButton];
    
    /***********************/
    
    // Tirer
    _drawButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.5 - 100, h * 0.85, 100, 30)];
    [_drawButton setTitle:@"Carte !" forState:UIControlStateNormal];
    [_drawButton setBackgroundImage:[UIImage imageNamed:@"buttonA.png"] forState:UIControlStateNormal];
    _drawButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_drawButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_drawButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_drawButton addTarget:self action:@selector(playerDrawFromButton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_drawButton];
    
    // Rester
    _standButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.5, h * 0.85, 100, 30)];
    [_standButton setTitle:@"Je reste" forState:UIControlStateNormal];
    [_standButton setBackgroundImage:[UIImage imageNamed:@"buttonA.png"] forState:UIControlStateNormal];
    _standButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_standButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_standButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_standButton addTarget:self action:@selector(playerStands) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_standButton];
    
    /*********************/
    
    // Rejouer
    _playAgainButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.05, h * 0.1, 55, 40)];
    [_playAgainButton setBackgroundImage:[UIImage imageNamed:@"playagain.png"] forState:UIControlStateNormal];
    [_playAgainButton addTarget:self action:@selector(playerReplays) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_playAgainButton];
    
    // Abandonner
    _surrenderButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.05, h * 0.3, 55, 40)];
    [_surrenderButton setBackgroundImage:[UIImage imageNamed:@"surrender.png"] forState:UIControlStateNormal];
    [_surrenderButton addTarget:self action:@selector(playerSurrends) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_surrenderButton];
    
    /*********************/
    
    // Doubler
    _doubleButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.98 - 80, h * 0.1, 80, 30)];
    [_doubleButton setTitle:@"Doubler" forState:UIControlStateNormal];
    [_doubleButton setBackgroundImage:[UIImage imageNamed:@"buttonA.png"] forState:UIControlStateNormal];
    _doubleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_doubleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_doubleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doubleButton addTarget:self action:@selector(playerDoubles) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_doubleButton];
    
    // S'assurer
    _insuranceButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.98 - 80, h * 0.3, 80, 30)];
    [_insuranceButton setTitle:@"S'assurer" forState:UIControlStateNormal];
    [_insuranceButton setBackgroundImage:[UIImage imageNamed:@"buttonA.png"] forState:UIControlStateNormal];
    _insuranceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_insuranceButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_insuranceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_insuranceButton addTarget:self action:@selector(playerStands) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_insuranceButton];
    
    // Séparer : TODO: A implémenter plus tard
    /*
    _separateButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 0.98 - 80, h * 0.5, 80, 30)];
    [_separateButton setTitle:@"Séparer" forState:UIControlStateNormal];
    [_separateButton setBackgroundImage:[UIImage imageNamed:@"buttonA.png"] forState:UIControlStateNormal];
    _separateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_separateButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_separateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_separateButton addTarget:self action:@selector(playerStands) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_separateButton];
    */
    // Initialisation des labels
    // Player label
    _playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(w * 0.5 , h * 0.5, 200, 20)];
    _playerLabel.text = @"0pts";
    [_playerLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_playerLabel];
    
    // Dealder label
    _dealerLabel = [[UILabel alloc] initWithFrame:CGRectMake(w * 0.5, h * 0.27, 200, 20)];
    _dealerLabel.text = @"0pts";
    [_dealerLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_dealerLabel];
    
    // Label du contenu de la banque
    _bankrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(w * 0.98 - 150, h * 0.98 - 20, 150, 20)];
    _bankrollLabel.text = [[NSString alloc] initWithFormat:@"Bankroll: %d", [_player bankroll]];
    [_bankrollLabel setTextAlignment:NSTextAlignmentRight];
    [_bankrollLabel setFont:[UIFont systemFontOfSize:12]];
    [_bankrollLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_bankrollLabel];
}

-(void)chooseBet
{
    // UIAlertView du choix de la mise
    UIAlertView *alert= [[UIAlertView alloc]
                         initWithTitle: @"Mises"
                         message: nil
                         delegate: self
                         cancelButtonTitle:nil
                         otherButtonTitles:nil];
    [alert addButtonWithTitle:@"20"];
    [alert addButtonWithTitle:@"50"];
    [alert addButtonWithTitle:@"100"];
    [alert addButtonWithTitle:@"500"];
    
    alert.tag = ALERTVIEW_BET;
    [alert show];
}

-(void)setup
{
    // Mise à jour de tous les boutons
    [_drawButton setEnabled:YES];
    [_standButton setEnabled:YES];
    
    [_doubleButton setEnabled:YES];
    [_insuranceButton setEnabled:NO];
    
    [_surrenderButton setEnabled:YES];
    
    // Mise à jour des labels
    _playerLabel.text = @"0pts";
    _dealerLabel.text = @"0pts";
    
    [_player setBankroll:[_player bankroll] - [_player currentBet]];
    _bankrollLabel.text = [[NSString alloc] initWithFormat:@"Bankroll: %d", [_player bankroll]];
    
    // Ajout du jeton
    NSString * filename = [[NSString alloc] init];
    
    switch([_player currentBet])
    {
        case 20:
            filename = @"redJeton.png";
            break;
        case 50:
            filename = @"blueJeton.png";
            break;
        
        case 100:
            filename = @"greenJeton.png";
            break;
            
        case 500:
            filename = @"blackJeton.png";
            break;
    }

    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    UIImage * cImage = [UIImage imageNamed:filename];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:cImage];
    CGRect rect = CGRectMake(w * 0.5, h, 30, 30); // Ici le tas de cartes est placé à 90% de la taille de l'écran
    imageView.frame = rect;
    [self.view addSubview:imageView];
    [_imageViewJetons addObject:imageView];
    
    [self animateImageView:imageView fromPos:CGPointMake(w * 0.5, h) toPos:CGPointMake(w * 0.32, h * 0.52) withAngle:0 withDestroy:NO];
    
    // Distribution des premières cartes
    [self playerDraws];
    [self dealerDraws];
    
    [self playerDraws];
    [self dealerDraws];
}

-(void) playerDrawFromButton
{
    [_surrenderButton setEnabled:NO];       // S'il pioche c'est qu'il ne peut plus abandonner
    [self playerDraws];
}

-(void) playerDraws
{
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    CGFloat stepT = (w * 9) / WIDTH_TABLE + (w * WIDTH_SLOT) / WIDTH_TABLE;
    
    // Tirage de la carte
    Card * c = [_cards drawCard];
    
    // Ici animation du déplacement de la carte
    // Décalage des images
    NSInteger index = [_player.hand getNumberCards];
    [self animateCard:c fromPos:CGPointMake(w * 0.68, h * 0.28) toPos:CGPointMake(w * 0.38 + stepT * index, h * 0.5725) withAngle: 0 flipFlapAtEnd:YES];
    
    // Ici ajout dans la main
    [_player.hand addCard:c];
    
    // Test si c'est un as,
    if ([c numberCard] == 1 && [_player.hand getValue:YES] <= 10)
    {
        _currentCard = (int)[_player.hand getNumberCards] - 1;
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Value of Ace" message:[NSString stringWithFormat:@"Score actuel: %ld", (long)[_player.hand getValue:YES] - 1] delegate:self cancelButtonTitle:nil otherButtonTitles:@"1", @"11", nil];
        alertView.tag = ALERTVIEW_ACE;
        [alertView show];
    }
    
    // Mise à jour du texte
    _playerLabel.text = [NSString stringWithFormat:@"%ldpts", (long)[_player.hand getValue:NO]];
    
    // Vérification qu'après avoir pioché il peut toujours jouer
    [self checkPlayerLoss];
}

-(void) playerDoubles
{
    [_player setState:Double];
    
    // On remet un jeton de la même valeur
    NSString * filename = [[NSString alloc] init];
    
    switch([_player currentBet])
    {
        case 20:
            filename = @"redJeton.png";
            break;
        case 50:
            filename = @"blueJeton.png";
            break;
            
        case 100:
            filename = @"greenJeton.png";
            break;
            
        case 500:
            filename = @"blackJeton.png";
            break;
    }
    
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    UIImage * cImage = [UIImage imageNamed:filename];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:cImage];
    CGRect rect = CGRectMake(w * 0.5, h, 30, 30);
    imageView.frame = rect;
    [self.view addSubview:imageView];
    [_imageViewJetons addObject:imageView];
    
    [self animateImageView:imageView fromPos:CGPointMake(w * 0.5, h) toPos:CGPointMake(w * 0.32, h * 0.52) withAngle:0 withDestroy:NO];
    
    int bet = [_player currentBet];
    int bankroll = [_player bankroll];
    [_player setBankroll:bankroll - bet];
    [_player setCurrentBet:bet * 2];
    
    [_doubleButton setEnabled:NO];
    
    [self playerDraws];
    if ([_player.hand getValue:YES] <= 21)
        [self playerStands];
}

-(void) playerSurrends
{
    [_player setState:Surrend];
    [self endGame:3 withMessage:nil];       // Abandon du joueur
}

-(void)playerStands
{
    // Si le joueur décide de rester, on désactive certains boutons
    [_drawButton setEnabled:NO];
    [_standButton setEnabled:NO];
    
    // Début du tour de la banque
    [self dealerPlays];
}

-(void)playerAssures
{
    [_player setState:Insurance];
    
    int bet = [_player currentBet];
    [_player setCurrentBet:bet + 1/2 * bet];
    
}

-(void)playerReplays
{
    // Clean des jetons
    for (int i = 0; i < [_imageViewJetons count]; i++)
        [[_imageViewJetons objectAtIndex:i] removeFromSuperview];
    
    // Clean de toutes les cartes
    for (int i = 0; i < [_allImageView count]; i++)
        [[_allImageView objectAtIndex:i] removeFromSuperview];
    
    // Clean et Reset de toutes les données
    _allImageView = nil;
    _imageViewJetons = nil;
    _player = nil;
    _dealer = nil;
    _cards = nil;
    _discards = nil;

    _cards = [Deck instanciateDeck];
    _discards = [[Deck alloc] init];
    
    _player = [[Player alloc] init];
    [_player setBankroll:1000];
    
    _dealer = [[Dealer alloc] init];
    
    _allImageView = [[NSMutableArray alloc] init];
    _imageViewJetons = [[NSMutableArray alloc] init];
    
    _playerLabel.text = @"0pts";
    _dealerLabel.text = @"0pts";
    _bankrollLabel.text = [[NSString alloc] initWithFormat:@"Bankroll: %d", [_player bankroll]];
    
    // On relance la partie avec la demande d'une nouvelle mise
    [self chooseBet];
}

-(void)dealerPlays
{
    // La banque pioche tant qu'elle a pas un score compris entre 17 et 21
    while([_dealer.hand getValue:YES] < 17)
    {
        [self dealerDraws];
    }
    
    // Swap de la carte cachée
    Card * c = [_dealer.hand getCardAtIndex:1];
    if (c.isClosed)
        [self flipCard:c];
    
    // Mise à jour du score de la banque
    _dealerLabel.text = [NSString stringWithFormat:@"%ldpts", (long)[_dealer.hand getValue:NO]];
    
    // On fait le processus pour savoir quel est le vainqueur
    [self checkWinner];
}

-(void) dealerDraws
{
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    CGFloat step = (w * 9) / WIDTH_TABLE + (w * WIDTH_SLOT) / WIDTH_TABLE;
    // Tirage de la carte
    Card * c = [_cards drawCard];
    
    // Ici animation du déplacement de la carte
    // Décalage des images
    NSInteger index = [_dealer.hand getNumberCards];

    if (index == 1)
    {
        c.isClosed = YES;
        [self animateCard:c fromPos:CGPointMake(w * 0.68, h * 0.28) toPos:CGPointMake(w * 0.38 + step * index, h * 0.1625) withAngle:0 flipFlapAtEnd:NO];
    }
    else
    {
        c.isClosed = NO;
        [self animateCard:c fromPos:CGPointMake(w * 0.68, h * 0.28) toPos:CGPointMake(w * 0.38 + step * index, h * 0.1625) withAngle:0 flipFlapAtEnd:YES];
    }
    
    // Test si c'est un as
    if ([c numberCard] == 1)
    {
        int score_tmp =(int) [_dealer.hand getValue:YES] - 1;
        if(score_tmp <= 10)
            c.indexForValue = 1;
    }
    
    // Test pour savoir l'assurance est permise
    if (index == 1)
    {
        Card * firstCard = [_dealer.hand getCardAtIndex:0];
        int value = (int)[firstCard numberCard];
        NSLog(@"%d", value);
        if (value == 10 || value == 11)
            [_insuranceButton setEnabled:YES];
    }
    
    // Ajout dans la main
    [_dealer.hand addCard:c];
        
    // Mise à jour de la valeur de la main
    _dealerLabel.text = [NSString stringWithFormat:@"%ldpts", (long)[_dealer.hand getValue:NO]];
}

-(void)checkPlayerLoss
{
    if ([_player.hand getValue:YES] > 21)       // Le joueur a fait + de 21pts
        [self endGame:2 withMessage:nil];
}

-(void)checkWinner
{
    int dealerScore = (int)[_dealer.hand getValue:YES];
    int playerScore = (int)[_player.hand getValue:YES];
    int dealerNbCards = (int)[_dealer.hand getNumberCards];
    int playerNbCards = (int)[_player.hand getNumberCards];
    
    if (dealerScore > 21)                   // La banque a dépassé 21
        [self endGame:1 withMessage:nil];
    else if (dealerScore > playerScore)     // La banque a fait un meilleur score que le joueur
        [self endGame:2 withMessage:((dealerScore == 21) ? @" Blackjack de la banque." : nil)];
    else if (dealerScore == playerScore)    // La banque et le joueur sont à égalité
    {
        if ( (dealerScore == 21) && (dealerNbCards == 2) && (dealerNbCards < playerNbCards) )
            [self endGame:2 withMessage:@" Blackjack de la banque."];
        else if ( (playerScore == 21) && (playerNbCards == 2) && (playerNbCards < dealerNbCards))
            [self endGame:1 withMessage:@" Vous avez fait un blackjack."];
        else
            [self endGame:4 withMessage:nil];
    }
    else                                    // Le joueur a fait un meilleur score que la banque
        [self endGame:1 withMessage:((playerScore == 21) ? @" Vous avez fait un blackjack." : nil)];
}

-(void) endGame:(int)winner withMessage:(NSString*)message
{
    // Cas pour flip la deuxième carte de la banque si la manche se termine prématurément
    Card * c = [_dealer.hand getCardAtIndex:1];
    if (c.isClosed == YES)
    {
        [self  flipCard:c];
        _dealerLabel.text = [NSString stringWithFormat:@"%ldpts", (long)[_dealer.hand getValue:NO]];
    }
        
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    
    int currBankroll = [_player bankroll];
    int currBet = [_player currentBet];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Winner" message:nil delegate:self cancelButtonTitle:@"Continuer" otherButtonTitles:nil];
    
    switch(winner)
    {
        case 1:         // Le joueur gagne
        {
            if ([_player state] == Insurance)
            {
                [_player setBankroll:(currBankroll + currBet * 2/3)];
            }
            else
            {
                [_player setBankroll:(currBankroll + currBet * 2)];
            }
            NSString * result = [[NSString alloc] initWithFormat:@"Vous avez battu la banque avec le score de %ld contre %ld.", (long)[_player.hand getValue:YES], (long)[_dealer.hand getValue:NO] ];
            if (message != nil)
                result = [result stringByAppendingString:message];
            [alertView setMessage:result];
            for (int i = 0; i < [_imageViewJetons count]; i++)
            {
                UIImageView * imageView = [_imageViewJetons objectAtIndex:i];
                [self animateImageView:imageView fromPos:CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y) toPos:CGPointMake(w * 0.5, h) withAngle:0 withDestroy:YES];
            }
            break;
        }
        case 2:         // La banque gagne
        {
            if ([_player state] == Insurance && [_dealer.hand getValue:YES] == 21)
            {
                 [_player setBankroll:(currBankroll + currBet)];
            }
            NSString * result = [[NSString alloc] initWithFormat:@"La banque vous a battu avec le score de %ld contre %ld.", (long)[_dealer.hand getValue:YES], (long)[_player.hand getValue:NO] ];
            if (message != nil)
                result = [result stringByAppendingString:message];
            [alertView setMessage:result];
            for (int i = 0; i < [_imageViewJetons count]; i++)
            {
                UIImageView * imageView = [_imageViewJetons objectAtIndex:i];
                [self animateImageView:imageView fromPos:CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y) toPos:CGPointMake(w * 0.5, -100) withAngle:0 withDestroy:YES];
            }
            break;
        }

        case 3:         // Le joueur a abandonné
        {
            [_player setBankroll:(currBankroll + currBet / 2)];
            [alertView setMessage:@"Vous avez abandonné."];
            for (int i = 0; i < [_imageViewJetons count]; i++)
            {
                UIImageView * imageView = [_imageViewJetons objectAtIndex:i];
                [self animateImageView:imageView fromPos:CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y) toPos:CGPointMake(w * 0.5, h) withAngle:0 withDestroy:YES];
            }
            break;
        }
        case 4:         // Le joueur et la banque ont fait égalité
        {
            [_player setBankroll:(currBankroll + currBet)];
            [alertView setMessage:@"Egalité. Vous récupérez la mise de départ."];
            for (int i = 0; i < [_imageViewJetons count]; i++)
            {
                UIImageView * imageView = [_imageViewJetons objectAtIndex:i];
                [self animateImageView:imageView fromPos:CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y) toPos:CGPointMake(w * 0.5, h) withAngle:0 withDestroy:YES];
            }
            break;
        }
    }
    
    _bankrollLabel.text = [[NSString alloc] initWithFormat:@"Bankroll: %d", [_player bankroll]];
    
    alertView.tag = ALERTVIEW_WINNER;
    [alertView show];
}

-(void) animateCard:(Card*)card fromPos:(CGPoint)start toPos:(CGPoint)end withAngle:(CGFloat)angle flipFlapAtEnd:(BOOL)isFlipping
{
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    CGFloat wImg = (w * WIDTH_SLOT) / WIDTH_TABLE;
    CGFloat hImg = (h * HEIGHT_SLOT) / HEIGHT_TABLE;
    
    UIImage * cImage = [UIImage imageNamed:@"cover.png"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:cImage];
    CGRect rect = CGRectMake(start.x, start.y, wImg, hImg);
    imageView.frame = rect;
    [self.view addSubview:imageView];
    [self.allImageView addObject:imageView];
    card.imageViewIndex = (int)[self.allImageView count] - 1;
    
    [UIView animateWithDuration:1.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [UIView beginAnimations:@"Animate Drawing" context:nil];
                         [UIView setAnimationDuration:1.0];
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationRepeatCount:0];
                         [UIView setAnimationRepeatAutoreverses:NO];
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                         
                         imageView.frame = CGRectMake(end.x, end.y, imageView.frame.size.width, imageView.frame.size.height);
                         imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(angle));
                         
                         [UIView commitAnimations];
                     }
                     completion:^(BOOL finished){
                         if (finished && isFlipping)
                             [self flipCard:card];
                     }];
    
}

-(void) animateImageView:(UIImageView*)imageView fromPos:(CGPoint)start toPos:(CGPoint)end withAngle:(CGFloat)angle withDestroy:(BOOL) isDestroyed
{
    [UIView animateWithDuration:1.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [UIView beginAnimations:@"Animate Drawing" context:nil];
                         [UIView setAnimationDuration:1.0];
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationRepeatCount:0];
                         [UIView setAnimationRepeatAutoreverses:NO];
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                         
                         imageView.frame = CGRectMake(end.x, end.y, imageView.frame.size.width, imageView.frame.size.height);
                         imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(angle));
                         
                         [UIView commitAnimations];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void) flipCard:(Card*) card
{
    card.isClosed = NO;
    int index = card.imageViewIndex;
    UIImageView * imageView = [_allImageView objectAtIndex:index];
        
    [UIView beginAnimations:@"Flip Card" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:imageView cache:YES];
        
    imageView.image = [UIImage imageNamed:@"cover.png"];
    imageView.image = [UIImage imageNamed:[card getFilename]];
        
    [UIView commitAnimations];
}

-(void)reset
{
    CGFloat w = _screenRect.size.width;
    CGFloat h = _screenRect.size.height;
    
    // Clean de la main de la banque
    for (int i = 0; i < [_dealer.hand getNumberCards]; i++)
    {
        Card * c = [_dealer.hand getCardAtIndex:i];
        int index = c.imageViewIndex;
        UIImageView * imageView = [_allImageView objectAtIndex:index];
        
        CGPoint current = CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y);
        
        [self animateImageView:imageView fromPos:current toPos:CGPointMake(w * 0.70, h * 0.21) withAngle:-60 withDestroy: YES];
        c.imageViewIndex = -1;
        [_discards addCard:c withShuffle:NO];
    }
    
    // Clean de la main du joueur
    for (int i = 0; i < [_player.hand getNumberCards]; i++)
    {
        Card * c = [_player.hand getCardAtIndex:i];
        int index = c.imageViewIndex;
        UIImageView * imageView = [_allImageView objectAtIndex:index];
        
        CGPoint current = CGPointMake(imageView.frame.origin.x, imageView.frame.origin.y);
        
        [self animateImageView:imageView fromPos:current toPos:CGPointMake(w * 0.70, h * 0.21) withAngle:-60 withDestroy:YES];
        c.imageViewIndex = -1;
        [_discards addCard:c withShuffle:NO];
    }
    
    // Si la taille du deck a atteint moins de 25% on réinjecte la défausse
    if ([_cards numberCard] < [_cards numberCardInit] * 0.25)
    {
        [_cards addCardsFromDeck:_discards withShuffle:true];
        [_discards removeAllCards];
        
        for (int i = 0; i < [_allImageView count]; i++)
            [[_allImageView objectAtIndex:i] removeFromSuperview];
        [_allImageView removeAllObjects];
    }
    
    // Clean des jetons
    for (int i = 0; i < [_imageViewJetons count]; i++)
    {
        [[_imageViewJetons objectAtIndex:i] removeFromSuperview];
    }
    [_imageViewJetons removeAllObjects];

    _player.hand = nil;
    _dealer.hand = nil;
    
    _player.hand = [[Hand alloc] init];
    _dealer.hand = [[Hand alloc] init];
    
    [_player setState:Normal];
    
    [self chooseBet];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERTVIEW_BET)
    {
        NSArray * values = [[NSArray alloc] initWithObjects: [NSNumber numberWithInt:20], [NSNumber numberWithInt:50], [NSNumber numberWithInt:100], [NSNumber numberWithInt:500], nil];
        int value = (int)[[values objectAtIndex:buttonIndex] integerValue];
        if (value <= [_player bankroll])
        {
            [_player setCurrentBet:value];
            [self setup];
        }
        else
            [self playerReplays];
    }
    else if (alertView.tag == ALERTVIEW_ACE)
    {
        [[_player.hand getCardAtIndex:_currentCard] askForUserValue:(int)buttonIndex];
        _playerLabel.text = [NSString stringWithFormat:@"%ldpts", (long)[_player.hand getValue:NO]];
    }
    else if (alertView.tag == ALERTVIEW_WINNER)
    {
        [self reset];
    }
}

-(void)quit
{
    exit(0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
