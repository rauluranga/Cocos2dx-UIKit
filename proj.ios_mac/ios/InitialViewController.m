//
//  InitialViewController.m
//  Cocos2dx-UIKit
//
//  Created by Alwyn Savio Concessao on 25/05/16.
//
//

#import "InitialViewController.h"
#import "GameViewController.h"
#import "MenuViewController.h"
#import "SWRevealViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)modalButtonAction:(id)sender {
    
    GameViewController *gameView = [[GameViewController alloc]init];
    gameView.presentationStyle=@"Modal";
    [self presentViewController:gameView animated:YES completion:nil];
            
}


- (IBAction)swButtonAction:(id)sender {
    
    MenuViewController *rightViewController = [[MenuViewController alloc] init];
    GameViewController *frontViewController = [[GameViewController alloc] init];
    frontViewController.presentationStyle=@"Navigation";
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] init];
    [mainRevealController setRightViewController:rightViewController];
    [mainRevealController setFrontViewController:frontViewController];
        
    [[[UIApplication sharedApplication]delegate] window].rootViewController=mainRevealController;
    [[[[UIApplication sharedApplication]delegate] window] makeKeyAndVisible];
}

@end
