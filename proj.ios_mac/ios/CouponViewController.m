//
//  CouponViewController.m
//  LasAlitas
//
//  Created by Raul on 9/11/15.
//
//

#import "CouponViewController.h"
#import "GameVieWController.h"

@interface CouponViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *couponContainer;

@end

@implementation CouponViewController

- (id)init
{
    self = [super initWithNibName:@"CouponViewController" bundle:nil];
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
- (IBAction)dismiss:(id)sender {
    [self.gameViewController hideCoupon];
}

- (void)viewDidLoad {
    NSLog(@"Coupon.viewDidLoad");
    [self.couponContainer setScrollEnabled:YES];
    [self.couponContainer setContentSize:CGSizeMake(375, 974)];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    NSLog(@"Coupon.viewDidUnload");
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
