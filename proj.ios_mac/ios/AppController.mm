#import "AppController.h"

#import "SWRevealViewController.h"
#import "MenuViewController.h"
#import "GameViewController.h"
#import "AppDelegate.h"
#import "LocatorViewController.h"

// cocos2d application instance
static AppDelegate s_sharedApplication;

@interface AppController()

@end

@implementation AppController

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    MenuViewController *rightViewController = [[MenuViewController alloc] init];
    GameViewController *frontViewController = [[GameViewController alloc] init];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc] init];
    [mainRevealController setRightViewController:rightViewController];
    [mainRevealController setFrontViewController:frontViewController];
    
    self.viewController = mainRevealController;
    
    self.window.rootViewController = mainRevealController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end