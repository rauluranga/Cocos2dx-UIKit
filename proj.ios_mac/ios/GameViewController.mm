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
#import "InitialViewController.h"
#include "HelloWorldScene.h"


static cocos2d::Size designResolutionSize = cocos2d::Size(480, 320);
static cocos2d::Size smallResolutionSize = cocos2d::Size(480, 320);
static cocos2d::Size mediumResolutionSize = cocos2d::Size(1024, 768);
static cocos2d::Size largeResolutionSize = cocos2d::Size(2048, 1536);

@interface GameViewController () {
    
  }

  @property (strong, nonatomic) IBOutlet UIButton *menuButton;
  @property (strong, nonatomic) CCEAGLView *eaglView;
  @property (strong, nonatomic) CouponViewController *coupon_vc;
  @property (nonatomic) BOOL isCouponActive;

 -(void) login;
 -(void)cleanUp;

@end

@implementation GameViewController

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
    
    cocos2d::Application *app = cocos2d::Application::getInstance();
    app->initGLContextAttrs();
    cocos2d::GLViewImpl::convertAttrs();

        cocos2d::EventListenerCustom *_listener;
    
    if([self.presentationStyle isEqualToString:@"Navigation"]){
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuButton addTarget:revealViewController
                            action:@selector(rightRevealToggle:)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    
        
        self.menuButton.hidden=NO;
        self.eaglView = [CCEAGLView viewWithFrame: [[UIScreen mainScreen] bounds]
                                      pixelFormat: (NSString*)cocos2d::GLViewImpl::_pixelFormat
                                      depthFormat: cocos2d::GLViewImpl::_depthFormat
                               preserveBackbuffer: NO
                                       sharegroup: nil
                                    multiSampling: NO
                                  numberOfSamples: 0 ];
        
        // Enable or disable multiple touches
        [self.eaglView setMultipleTouchEnabled:NO];
        
        [self.view insertSubview:self.eaglView atIndex:0];
        
   
    // IMPORTANT: Setting the GLView should be done after creating the RootViewController
    cocos2d::GLView *glview = cocos2d::GLViewImpl::createWithEAGLView(self.eaglView);
    cocos2d::Director::getInstance()->setOpenGLView(glview);
    
    //*/
    //@see http://www.cocos2d-x.org/wiki/EventDispatcher_Mechanism
    _listener = cocos2d::EventListenerCustom::create("game_custom_event1", [=](cocos2d::EventCustom* event){
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
        
   
    
    }else if([self.presentationStyle isEqualToString:@"Modal"]){
        
        self.menuButton.hidden=YES;
        self.eaglView = [CCEAGLView viewWithFrame: [[UIScreen mainScreen] bounds]
                                      pixelFormat: (NSString*)cocos2d::GLViewImpl::_pixelFormat
                                      depthFormat: cocos2d::GLViewImpl::_depthFormat
                               preserveBackbuffer: NO
                                       sharegroup: nil
                                    multiSampling: NO
                                  numberOfSamples: 0 ];
        
        // Enable or disable multiple touches
        [self.eaglView setMultipleTouchEnabled:NO];
        
        [self.view insertSubview:self.eaglView atIndex:0];
        

        // IMPORTANT: Setting the GLView should be done after creating the RootViewController
        cocos2d::GLView *glview = cocos2d::GLViewImpl::createWithEAGLView(self.eaglView);
        cocos2d::Director::getInstance()->setOpenGLView(glview);
        
        //*/
        //@see http://www.cocos2d-x.org/wiki/EventDispatcher_Mechanism
        _listener = cocos2d::EventListenerCustom::create("game_custom_event2", [=](cocos2d::EventCustom* event){
            printf("game_custom_event2\n");
            [self closeGameScene];
            
        
        });
        cocos2d::Director::getInstance()->getEventDispatcher()->addEventListenerWithFixedPriority(_listener, 1);
        app->run();
    }
   
    
    
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
    if([self.presentationStyle caseInsensitiveCompare:@"Navigation"] == NSOrderedSame){
    if(!self.isCouponActive) {
        cocos2d::Director::getInstance()->end();
        [self performSelector:@selector(cleanUp) withObject:nil afterDelay:0.45];
    }
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self.eaglView];
    if([self.presentationStyle caseInsensitiveCompare:@"Modal"] == NSOrderedSame){
        
        [self cleanUp];
    }
    

}

-(void)closeGameScene{
    
    cocos2d::Director::getInstance()->end();
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)cleanUp {
    
    
    if (self.eaglView) {
        
        self.eaglView = nil;
    }
    
    if (_coupon_vc) {
        
        self.eaglView = nil;
    }
    _menuButton = nil;
}

- (void)viewDidUnload {
    NSLog(@"GameViewController.viewDidUnload");
    [super viewDidUnload];
}


@end
