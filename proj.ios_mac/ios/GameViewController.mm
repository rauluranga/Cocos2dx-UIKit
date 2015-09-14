//
//  GameViewController.m
//  LasAlitas
//
//  Created by Raul on 9/11/15.
//
//

#import "GameViewController.h"
#import "CouponViewController.h"
#import "SWRevealViewController.h"
#import "platform/ios/CCEAGLView-ios.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "AppController.h"
#import "SWRevealViewController.h"
#include "HelloWorldScene.h"


static cocos2d::Size designResolutionSize = cocos2d::Size(480, 320);
static cocos2d::Size smallResolutionSize = cocos2d::Size(480, 320);
static cocos2d::Size mediumResolutionSize = cocos2d::Size(1024, 768);
static cocos2d::Size largeResolutionSize = cocos2d::Size(2048, 1536);

@interface GameViewController () {
    __weak IBOutlet UIButton *_menuButton;
  }

  @property (weak, nonatomic) IBOutlet UIButton *menuButton;
  @property (strong, nonatomic) CCEAGLView *eaglView;
  @property (strong, nonatomic) CouponViewController *coupon_vc;
  @property (nonatomic) BOOL isCouponActive;

 -(void) login;
 -(void)cleanUp;

@end

@implementation GameViewController

@synthesize menuButton = _menuButton;
@synthesize eaglView = _eaglView;

- (CouponViewController *)coupon_vc
{
    if(!_coupon_vc) {
        _coupon_vc = [[CouponViewController alloc] init];
        _coupon_vc.gameViewController = self;
    }
    return _coupon_vc;
}

- (id)init
{
    self = [super initWithNibName:@"GameViewController" bundle:nil];
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
        [self.menuButton addTarget:revealViewController
                            action:@selector(rightRevealToggle:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
    cocos2d::Application *app = cocos2d::Application::getInstance();
    app->initGLContextAttrs();
    cocos2d::GLViewImpl::convertAttrs();
    
    // Init the CCEAGLView
    CCEAGLView *_ccEAGLView = [CCEAGLView viewWithFrame: [[UIScreen mainScreen] bounds]
                                         pixelFormat: (NSString*)cocos2d::GLViewImpl::_pixelFormat
                                         depthFormat: cocos2d::GLViewImpl::_depthFormat
                                  preserveBackbuffer: NO
                                          sharegroup: nil
                                       multiSampling: NO
                                     numberOfSamples: 0 ];
    
    // Enable or disable multiple touches
    [_ccEAGLView setMultipleTouchEnabled:NO];
    
    [self.view insertSubview:_ccEAGLView atIndex:0];
    
    // IMPORTANT: Setting the GLView should be done after creating the RootViewController
    cocos2d::GLView *glview = cocos2d::GLViewImpl::createWithEAGLView(_ccEAGLView);
    cocos2d::Director::getInstance()->setOpenGLView(glview);
    
    //*/
    //@see http://www.cocos2d-x.org/wiki/EventDispatcher_Mechanism
    cocos2d::EventListenerCustom *_listener = cocos2d::EventListenerCustom::create("game_custom_event1", [=](cocos2d::EventCustom* event){
        printf("game_custom_event1\n");
        SWRevealViewController *rootController =(SWRevealViewController*)[[(AppController*)
                                                                           [[UIApplication sharedApplication]delegate] window] rootViewController];
        GameViewController *g_vc = (GameViewController*)rootController.frontViewController;
        [g_vc showCoupon];

    });
    cocos2d::Director::getInstance()->getEventDispatcher()->addEventListenerWithFixedPriority(_listener, 1);
    //cocos2d::Director::getInstance()->getEventDispatcher()->removeEventListener(_listener);
    //*/
    
    AppDelegate *app_delegate = (AppDelegate*) app;
    app_delegate->setupMainScene();
    
    self.eaglView = _ccEAGLView;
    
}

-(void)login {
    
}

-(void)showCoupon {
    if(!self.isCouponActive) {
        self.isCouponActive = YES;
        cocos2d::Director::getInstance()->pause();
        [self.coupon_vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:self.coupon_vc animated:YES completion:nil];
    }
}

-(void)hideCoupon {
    if(self.isCouponActive) {
       self.isCouponActive = NO;
        cocos2d::Director::getInstance()->pause();
       [self.coupon_vc dismissViewControllerAnimated:YES completion:^{
           cocos2d::Director::getInstance()->resume();
       }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewDidDisappear:(BOOL)animated {
    NSLog(@"GameViewController.viewDidDisappear");
    if(!self.isCouponActive) {
        cocos2d::Director::getInstance()->end();
        [self performSelector:@selector(cleanUp) withObject:nil afterDelay:0.45];
    }
}

-(void)cleanUp {
    if (_eaglView) {
        [_eaglView release];
        _eaglView = nil;
    }
    
    if (_coupon_vc) {
        [_coupon_vc release];
        _eaglView = nil;
    }
    _menuButton = nil;
}

- (void)viewDidUnload {
    NSLog(@"GameViewController.viewDidUnload");
    [self cleanUp];
    [super viewDidUnload];
}


@end
