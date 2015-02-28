//
//  ViewController.m
//  BlackjackProject
//
//  Created by arivet on 16/02/2015.
//  Copyright (c) 2015 bhrtw. All rights reserved.
//

#import "ViewController.h"
#import "GameManager.h"
#import "Hand.h"
#import "Card.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _gm = [[GameManager alloc] initWithNibName:@"GameManager" bundle:nil];
    [self.view addSubview:_gm.view];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
