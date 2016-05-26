#import "AppController.h"

#import "SWRevealViewController.h"
#import "MenuViewController.h"
#import "GameViewController.h"
#import "InitialViewController.h"
#import "AppDelegate.h"
#import "LocatorViewController.h"

// cocos2d application instance
static AppDelegate s_sharedApplication;

@interface AppController()

@end

@implementation AppController

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    InitialViewController *initialVC = [[InitialViewController alloc]init];
    
    self.window.rootViewController = initialVC;
    
    [self.window makeKeyAndVisible];

    return YES;
}

@end