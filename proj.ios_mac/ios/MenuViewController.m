//
//  MenuViewController.m
//  LasAlitas
//
//  Created by Raul on 9/11/15.
//
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "LocatorViewController.h"
#import "InitialViewController.h"
#import "GameViewController.h"


@interface MenuViewController ()
  @property (weak, nonatomic) IBOutlet UIButton *wingaFightButton;
  @property (weak, nonatomic) IBOutlet UIButton *storeLocatorButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation MenuViewController

- (id)init
{
    self = [super initWithNibName:@"MenuViewController" bundle:nil];
    if (self != nil)
    {
        // Further initialization if needed
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
    NSAssert(NO, @"Initialize with -init");
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushGameViewController:(id)sender {
    
    if(![self.revealViewController.frontViewController isKindOfClass:[GameViewController class]]){
        
    GameViewController *_gameViewController = [[GameViewController alloc] init];
    _gameViewController.presentationStyle=@"Navigation";
        
    [self.revealViewController pushFrontViewController:_gameViewController animated:YES];
    
    }

}

- (IBAction)pushStoreLocator:(id)sender {
    LocatorViewController *_locatorViewController = [[LocatorViewController alloc] init];
    [self.revealViewController pushFrontViewController:_locatorViewController animated:YES];
}
- (IBAction)closeButtonAction:(id)sender {
    
    InitialViewController *initialView = [[InitialViewController alloc]init];
    [[[UIApplication sharedApplication] delegate] window].rootViewController=initialView;
    [[[[UIApplication sharedApplication]delegate]window] makeKeyAndVisible];
    [self.revealViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

@end
