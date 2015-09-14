//
//  LocatorViewController.m
//  LasAlitas
//
//  Created by Raul on 9/11/15.
//
//

#import "LocatorViewController.h"
#import "SWRevealViewController.h"

@interface LocatorViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sidebarButton;
@end

@implementation LocatorViewController

- (id)init
{
    self = [super initWithNibName:@"LocatorViewController" bundle:nil];
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
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton addTarget:revealViewController
                               action:@selector(rightRevealToggle:)
                     forControlEvents:UIControlEventTouchUpInside];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewDidUnload {
    
    NSLog(@"LocatorViewController.viewDidUnload");
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
