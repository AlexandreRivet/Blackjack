//
//  GameViewController.m
//  Blackjack
//
//  Created by arivet on 14/01/2015.
//  Copyright (c) 2015 arivet. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

#import "Card.h"
#import "Deck.h"
#import "Hand.h"
#import "Player.h"
#import "Looser.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    // Création du tableau de cartes
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    int numberDeck = 6;
    for (int i = 0; i < numberDeck; i++)
    {
        for (int color = 0; color <= 3; color++)
        {
            for (int numberCard = 1; numberCard <= 13; numberCard++)
            {
                [cards addObject:[[Card alloc] initWithCardNumber:numberCard color:color]];
            }
        }
    }
    
    Deck* d = [[Deck alloc] initWithCards:cards];
    NSString* tmp = [NSString stringWithFormat:@"%@", [d description]];
    NSLog(@"%@", tmp);
    // Hand* h = [[Hand alloc] init];
    // Ajout de la 1ère carte
    // [h addCard:[d drawCard]];
    // Ajout de la 2ème carte
    // [h addCard:[d drawCard]];
    // NSLog([NSString stringWithFormat:@"%lu", (unsigned long)[h getValue]]);
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    Player * player = [[Player alloc] init];
    Looser * looser = [[Looser alloc] init];
    
    [player drawCard];
    [looser drawCard];
    
    
    

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
