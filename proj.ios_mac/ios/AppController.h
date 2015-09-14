#import <UIKit/UIKit.h>

@class SWRevealViewController;

@interface AppController : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;

@end

